import 'package:dio/dio.dart';
import 'package:drift/drift.dart';

import '../../core/errors/app_error.dart';
import '../api/api_client.dart';
import '../db/app_database.dart';

abstract interface class PullSyncClient {
  Future<PullSyncPage> pull({
    required String tenantId,
    required String entityType,
    String? cursor,
  });
}

final class PullSyncPage {
  const PullSyncPage({required this.changes, this.cursor});

  final List<ServerEntityChange> changes;
  final String? cursor;
}

final class ServerEntityChange {
  const ServerEntityChange({
    required this.entityType,
    required this.data,
    this.operation,
  });

  final String entityType;
  final Map<String, Object?> data;
  final String? operation;
}

final class EmptyPullSyncClient implements PullSyncClient {
  const EmptyPullSyncClient();

  @override
  Future<PullSyncPage> pull({
    required String tenantId,
    required String entityType,
    String? cursor,
  }) async {
    return PullSyncPage(changes: const [], cursor: cursor);
  }
}

final class DioPullSyncClient implements PullSyncClient {
  const DioPullSyncClient(this._client);

  final ApiClient _client;

  @override
  Future<PullSyncPage> pull({
    required String tenantId,
    required String entityType,
    String? cursor,
  }) async {
    if (_client.dio.options.baseUrl.contains('example.invalid')) {
      return PullSyncPage(changes: const [], cursor: cursor);
    }

    try {
      final response = await _client.dio.get<Map<String, Object?>>(
        '/sync/pull',
        queryParameters: {
          'tenantId': tenantId,
          'entityType': entityType,
          'cursor': ?cursor,
        },
      );
      return _parsePullPage(response.data ?? const {});
    } on DioException catch (error, stackTrace) {
      throw NetworkError(
        message: 'Sync pull failed.',
        cause: error,
        stackTrace: stackTrace,
      );
    }
  }

  PullSyncPage _parsePullPage(Map<String, Object?> data) {
    final rawChanges = data['changes'];
    final changes = rawChanges is List
        ? rawChanges.whereType<Map>().map((raw) {
            final map = Map<String, Object?>.from(raw);
            final entityType = map.remove('entityType')?.toString();
            final operation = map.remove('operation')?.toString();
            final rawData = map.remove('data');
            final changeData = rawData is Map
                ? Map<String, Object?>.from(rawData)
                : map;

            if (entityType == null || entityType.trim().isEmpty) {
              throw const FormatException(
                'Sync pull change is missing entityType.',
              );
            }

            return ServerEntityChange(
              entityType: entityType,
              operation: operation,
              data: changeData,
            );
          }).toList()
        : const <ServerEntityChange>[];

    return PullSyncPage(
      changes: changes,
      cursor: (data['nextCursor'] ?? data['cursor'])?.toString(),
    );
  }
}

final class PullSyncService {
  const PullSyncService({
    required this.database,
    this.client = const EmptyPullSyncClient(),
    this.clock,
  });

  static const defaultEntityTypes = [
    'tenants',
    'users',
    'customers',
    'objects',
    'installations',
    'work_orders',
    'work_order_installations',
    'checklist_templates',
    'checklist_template_items',
    'checklist_answers',
    'measurements',
    'defects',
    'photos',
    'time_entries',
    'materials',
    'work_order_materials',
    'reports',
  ];

  final AppDatabase database;
  final PullSyncClient client;
  final DateTime Function()? clock;

  Future<void> pull({required String tenantId}) async {
    await _ensureSyncStates(tenantId);
    final states = await database.syncStateDao.watchForTenant(tenantId).first;
    final pulledAt = (clock ?? DateTime.now).call().toUtc().toIso8601String();

    for (final state in states) {
      final page = await client.pull(
        tenantId: tenantId,
        entityType: state.entityType,
        cursor: state.cursor,
      );

      await database.transaction(() async {
        for (final change in page.changes) {
          await _applyChange(
            tenantId: tenantId,
            change: change,
            pulledAt: pulledAt,
          );
        }

        await database
            .into(database.syncStates)
            .insertOnConflictUpdate(
              state.copyWith(
                lastPullAt: Value(pulledAt),
                lastSuccessfulSyncAt: Value(pulledAt),
                cursor: Value(page.cursor ?? state.cursor),
              ),
            );
      });
    }
  }

  Future<void> _ensureSyncStates(String tenantId) async {
    final existingStates = await database.syncStateDao
        .watchForTenant(tenantId)
        .first;
    final existingTypes = existingStates
        .map((state) => state.entityType)
        .toSet();

    for (final entityType in defaultEntityTypes) {
      if (existingTypes.contains(entityType)) {
        continue;
      }
      await database
          .into(database.syncStates)
          .insertOnConflictUpdate(
            SyncStatesCompanion.insert(
              id: 'sync-$entityType',
              tenantId: tenantId,
              entityType: entityType,
            ),
          );
    }
  }

  Future<void> _applyChange({
    required String tenantId,
    required ServerEntityChange change,
    required String pulledAt,
  }) async {
    final entityType = _normalizeEntityType(change.entityType);
    final id = change.data['id']?.toString();
    if (id == null || id.isEmpty) {
      throw FormatException('Sync pull $entityType change is missing id.');
    }

    final hasUnsyncedLocalChange = await _hasUnsyncedLocalChange(
      entityType: entityType,
      id: id,
    );
    if (hasUnsyncedLocalChange) {
      await _markConflict(entityType: entityType, id: id, pulledAt: pulledAt);
      return;
    }

    final operation = change.operation?.trim().toLowerCase();
    final isDelete =
        operation == 'delete' || change.data['deletedAt']?.toString() != null;
    if (isDelete) {
      await _applyRemoteDelete(
        entityType: entityType,
        id: id,
        deletedAt: change.data['deletedAt']?.toString() ?? pulledAt,
        version: _intValue(change.data['version']) ?? 1,
        pulledAt: pulledAt,
      );
      return;
    }

    final data = _withSyncedMetadata(
      tenantId: tenantId,
      data: change.data,
      pulledAt: pulledAt,
    );
    await _upsertEntity(entityType, data);
  }

  Map<String, Object?> _withSyncedMetadata({
    required String tenantId,
    required Map<String, Object?> data,
    required String pulledAt,
  }) {
    return {
      ...data,
      'tenantId': data['tenantId'] ?? tenantId,
      'createdAt': data['createdAt'] ?? pulledAt,
      'updatedAt': data['updatedAt'] ?? pulledAt,
      'deletedAt': data['deletedAt'],
      'version': _intValue(data['version']) ?? 1,
      'syncStatus': 'synced',
      'lastSyncedAt': pulledAt,
    };
  }

  Future<void> _upsertEntity(
    String entityType,
    Map<String, Object?> data,
  ) async {
    await switch (entityType) {
      'tenant' =>
        database
            .into(database.tenants)
            .insertOnConflictUpdate(TenantRow.fromJson(data)),
      'user' =>
        database
            .into(database.users)
            .insertOnConflictUpdate(UserRow.fromJson(data)),
      'customer' =>
        database
            .into(database.customers)
            .insertOnConflictUpdate(CustomerRow.fromJson(data)),
      'object' =>
        database
            .into(database.customerObjects)
            .insertOnConflictUpdate(CustomerObjectRow.fromJson(data)),
      'installation' =>
        database
            .into(database.installations)
            .insertOnConflictUpdate(InstallationRow.fromJson(data)),
      'work_order' =>
        database
            .into(database.workOrders)
            .insertOnConflictUpdate(WorkOrderRow.fromJson(data)),
      'work_order_installation' =>
        database
            .into(database.workOrderInstallations)
            .insertOnConflictUpdate(WorkOrderInstallationRow.fromJson(data)),
      'checklist_template' =>
        database
            .into(database.checklistTemplates)
            .insertOnConflictUpdate(ChecklistTemplateRow.fromJson(data)),
      'checklist_template_item' =>
        database
            .into(database.checklistTemplateItems)
            .insertOnConflictUpdate(ChecklistTemplateItemRow.fromJson(data)),
      'checklist_answer' =>
        database
            .into(database.checklistAnswers)
            .insertOnConflictUpdate(ChecklistAnswerRow.fromJson(data)),
      'measurement' =>
        database
            .into(database.measurements)
            .insertOnConflictUpdate(MeasurementRow.fromJson(data)),
      'defect' =>
        database
            .into(database.defects)
            .insertOnConflictUpdate(DefectRow.fromJson(data)),
      'photo' =>
        database
            .into(database.photos)
            .insertOnConflictUpdate(PhotoRow.fromJson(data)),
      'time_entry' =>
        database
            .into(database.timeEntries)
            .insertOnConflictUpdate(TimeEntryRow.fromJson(data)),
      'material' =>
        database
            .into(database.materials)
            .insertOnConflictUpdate(MaterialRow.fromJson(data)),
      'work_order_material' =>
        database
            .into(database.workOrderMaterials)
            .insertOnConflictUpdate(WorkOrderMaterialRow.fromJson(data)),
      'report' =>
        database
            .into(database.reports)
            .insertOnConflictUpdate(ReportRow.fromJson(data)),
      _ => throw UnsupportedError('Unsupported sync entity type: $entityType'),
    };
  }

  Future<bool> _hasUnsyncedLocalChange({
    required String entityType,
    required String id,
  }) async {
    final tableName = _tableNameFor(entityType);
    final row = await database
        .customSelect(
          'SELECT sync_status FROM $tableName WHERE id = ? LIMIT 1',
          variables: [Variable.withString(id)],
        )
        .getSingleOrNull();
    final syncStatus = row?.data['sync_status']?.toString();
    return syncStatus != null && syncStatus != 'synced';
  }

  Future<void> _markConflict({
    required String entityType,
    required String id,
    required String pulledAt,
  }) async {
    final tableName = _tableNameFor(entityType);
    await database.customUpdate(
      'UPDATE $tableName SET sync_status = ?, updated_at = ? WHERE id = ?',
      variables: [
        Variable.withString('conflict'),
        Variable.withString(pulledAt),
        Variable.withString(id),
      ],
    );
  }

  Future<void> _applyRemoteDelete({
    required String entityType,
    required String id,
    required String deletedAt,
    required int version,
    required String pulledAt,
  }) async {
    final tableName = _tableNameFor(entityType);
    await database.customUpdate(
      'UPDATE $tableName '
      'SET deleted_at = ?, updated_at = ?, version = ?, '
      'sync_status = ?, last_synced_at = ? '
      'WHERE id = ?',
      variables: [
        Variable.withString(deletedAt),
        Variable.withString(pulledAt),
        Variable.withInt(version),
        Variable.withString('synced'),
        Variable.withString(pulledAt),
        Variable.withString(id),
      ],
    );
  }

  String _normalizeEntityType(String entityType) {
    return switch (entityType.trim()) {
      'tenants' => 'tenant',
      'users' => 'user',
      'customers' => 'customer',
      'objects' || 'customer_object' || 'customer_objects' => 'object',
      'installations' => 'installation',
      'work_orders' => 'work_order',
      'work_order_installations' => 'work_order_installation',
      'checklist_templates' => 'checklist_template',
      'checklist_template_items' => 'checklist_template_item',
      'checklist_answers' => 'checklist_answer',
      'measurements' => 'measurement',
      'defects' => 'defect',
      'photos' => 'photo',
      'time_entries' => 'time_entry',
      'materials' => 'material',
      'work_order_materials' => 'work_order_material',
      'reports' => 'report',
      final normalized => normalized,
    };
  }

  String _tableNameFor(String entityType) {
    return switch (entityType) {
      'tenant' => 'tenants',
      'user' => 'users',
      'customer' => 'customers',
      'object' => 'objects',
      'installation' => 'installations',
      'work_order' => 'work_orders',
      'work_order_installation' => 'work_order_installations',
      'checklist_template' => 'checklist_templates',
      'checklist_template_item' => 'checklist_template_items',
      'checklist_answer' => 'checklist_answers',
      'measurement' => 'measurements',
      'defect' => 'defects',
      'photo' => 'photos',
      'time_entry' => 'time_entries',
      'material' => 'materials',
      'work_order_material' => 'work_order_materials',
      'report' => 'reports',
      _ => throw UnsupportedError('Unsupported sync entity type: $entityType'),
    };
  }

  int? _intValue(Object? value) {
    return switch (value) {
      int() => value,
      num() => value.toInt(),
      String() => int.tryParse(value),
      _ => null,
    };
  }
}
