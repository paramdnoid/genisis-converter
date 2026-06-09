import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:drift/drift.dart' hide isNotNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kaminfeger_mobile/core/config/app_environment.dart';
import 'package:kaminfeger_mobile/data/api/api_client.dart';
import 'package:kaminfeger_mobile/data/db/app_database.dart';
import 'package:kaminfeger_mobile/data/sync/pull_sync_service.dart';
import 'package:kaminfeger_mobile/data/sync/work_order_notification_sink.dart';

import '../../helpers/fake_http_client_adapter.dart';

void main() {
  late AppDatabase database;

  setUp(() async {
    database = AppDatabase.forTesting(NativeDatabase.memory());
    await database.seedDevelopmentData();
  });

  tearDown(() async {
    await database.close();
  });

  test('downloads server changes and advances sync cursors', () async {
    final customer = await database.customerDao.getById(
      DevelopmentSeed.customerId,
    );
    final workOrder = await database.workOrderDao.getById(
      DevelopmentSeed.workOrderInspectionId,
    );
    final client = _FakePullSyncClient({
      'customers': PullSyncPage(
        cursor: 'customers-cursor-2',
        changes: [
          ServerEntityChange(
            entityType: 'customer',
            data: {
              ...customer!.toJson(),
              'displayName': 'Familie Keller Updated',
              'version': customer.version + 1,
            },
          ),
        ],
      ),
      'work_orders': PullSyncPage(
        cursor: 'work-orders-cursor-2',
        changes: [
          ServerEntityChange(
            entityType: 'work_order',
            data: {
              ...workOrder!.toJson(),
              'status': 'in_progress',
              'version': workOrder.version + 1,
            },
          ),
        ],
      ),
    });
    final service = PullSyncService(
      database: database,
      client: client,
      clock: () => DateTime.utc(2026, 1, 2, 10),
    );

    await service.pull(tenantId: DevelopmentSeed.tenantId);

    final updatedCustomer = await database.customerDao.getById(
      DevelopmentSeed.customerId,
    );
    final updatedWorkOrder = await database.workOrderDao.getById(
      DevelopmentSeed.workOrderInspectionId,
    );
    final syncStates = await database.syncStateDao
        .watchForTenant(DevelopmentSeed.tenantId)
        .first;

    expect(updatedCustomer?.displayName, 'Familie Keller Updated');
    expect(updatedCustomer?.syncStatus, 'synced');
    expect(updatedWorkOrder?.status, 'in_progress');
    expect(updatedWorkOrder?.syncStatus, 'synced');
    expect(
      syncStates.firstWhere((state) => state.entityType == 'customers').cursor,
      'customers-cursor-2',
    );
    expect(
      syncStates
          .firstWhere((state) => state.entityType == 'work_orders')
          .lastSuccessfulSyncAt,
      DateTime.utc(2026, 1, 2, 10).toIso8601String(),
    );
    expect(client.requestedEntityTypes, contains('customers'));
    expect(client.requestedEntityTypes, contains('work_orders'));
  });

  test('applies remote deletes as local soft deletes', () async {
    final client = _FakePullSyncClient({
      'objects': PullSyncPage(
        cursor: 'objects-cursor-2',
        changes: [
          ServerEntityChange(
            entityType: 'object',
            operation: 'delete',
            data: {
              'id': DevelopmentSeed.objectId,
              'deletedAt': DateTime.utc(2026, 1, 3).toIso8601String(),
              'version': 3,
            },
          ),
        ],
      ),
    });
    final service = PullSyncService(database: database, client: client);

    await service.pull(tenantId: DevelopmentSeed.tenantId);

    final object = await database.objectDao.getById(DevelopmentSeed.objectId);

    expect(object?.deletedAt, DateTime.utc(2026, 1, 3).toIso8601String());
    expect(object?.version, 3);
    expect(object?.syncStatus, 'synced');
  });

  test(
    'does not notify for work orders during initial bootstrap pull',
    () async {
      final existingOrder = await database.workOrderDao.getById(
        DevelopmentSeed.workOrderInspectionId,
      );
      final sink = _RecordingNotificationSink();
      final client = _FakePullSyncClient({
        'work_orders': PullSyncPage(
          cursor: 'work-orders-cursor-1',
          changes: [
            ServerEntityChange(
              entityType: 'work_order',
              data: {
                ...existingOrder!.toJson(),
                'id': 'remote-bootstrap-work-order',
                'orderNumber': 'WO-2026-0098',
                'title': 'Bootstrap-Auftrag',
                'version': 1,
              },
            ),
          ],
        ),
      });
      final service = PullSyncService(
        database: database,
        client: client,
        notificationSink: sink,
      );

      await service.pull(tenantId: DevelopmentSeed.tenantId);

      expect(sink.notifications, isEmpty);
      expect(
        await database.workOrderDao.getById('remote-bootstrap-work-order'),
        isNotNull,
      );
    },
  );

  test('notifies once for new work orders on cursor-based pulls', () async {
    await (database.update(database.syncStates)..where(
          (table) =>
              table.tenantId.equals(DevelopmentSeed.tenantId) &
              table.entityType.equals('work_orders'),
        ))
        .write(
          SyncStatesCompanion(
            cursor: const Value('work-orders-cursor-1'),
            lastSuccessfulSyncAt: Value(
              DateTime.utc(2026, 6, 8, 7).toIso8601String(),
            ),
          ),
        );

    final existingOrder = await database.workOrderDao.getById(
      DevelopmentSeed.workOrderInspectionId,
    );
    final sink = _RecordingNotificationSink();
    final client = _FakePullSyncClient({
      'work_orders': PullSyncPage(
        cursor: 'work-orders-cursor-2',
        changes: [
          ServerEntityChange(
            entityType: 'work_order',
            data: {
              ...existingOrder!.toJson(),
              'id': 'remote-new-work-order',
              'orderNumber': 'WO-2026-0099',
              'title': 'Neue Serverreinigung',
              'scheduledStart': DateTime.utc(2026, 6, 9, 8).toIso8601String(),
              'version': 1,
            },
          ),
        ],
      ),
    });
    final service = PullSyncService(
      database: database,
      client: client,
      notificationSink: sink,
    );

    await service.pull(tenantId: DevelopmentSeed.tenantId);

    final notification = sink.notifications.single;
    expect(notification.workOrderId, 'remote-new-work-order');
    expect(notification.orderNumber, 'WO-2026-0099');
    expect(notification.title, 'Neue Serverreinigung');
    expect(notification.scheduledStart, DateTime.utc(2026, 6, 9, 8));
    expect(
      await database.workOrderDao.getById('remote-new-work-order'),
      isNotNull,
    );
  });

  test('downloads tariff catalog, object tariffs, and service lines', () async {
    final client = _FakePullSyncClient({
      'tariff_catalog_items': const PullSyncPage(
        changes: [
          ServerEntityChange(
            entityType: 'tariff_catalog_item',
            data: {
              'id': 'tariff-cleaning',
              'tariffSystem': 'kfd',
              'code': '00+00',
              'description': 'Reinigung / Kontrolle von:',
              'defaultPrice': 0.0,
              'taxCategory': '1',
              'taxPoints': 0.0,
              'isActive': true,
              'version': 1,
            },
          ),
        ],
      ),
      'object_tariff_assignments': const PullSyncPage(
        changes: [
          ServerEntityChange(
            entityType: 'object_tariff_assignment',
            data: {
              'id': 'object-tariff-cleaning',
              'objectId': DevelopmentSeed.objectId,
              'tariffCatalogItemId': 'tariff-cleaning',
              'tariffSystem': 'kfd',
              'code': '00+00',
              'description': 'Reinigung von:',
              'position': 1,
              'defaultQuantity': 1.0,
              'unit': 'Stk',
              'priceOverride': 0.0,
              'billingCode': 'J',
              'isActive': true,
              'version': 1,
            },
          ),
        ],
      ),
      'work_order_service_lines': const PullSyncPage(
        changes: [
          ServerEntityChange(
            entityType: 'work_order_service_line',
            data: {
              'id': 'service-line-cleaning',
              'workOrderId': DevelopmentSeed.workOrderInspectionId,
              'objectTariffAssignmentId': 'object-tariff-cleaning',
              'tariffCatalogItemId': 'tariff-cleaning',
              'code': '00+00',
              'name': 'Reinigung von:',
              'quantity': 1.0,
              'unit': 'Stk',
              'unitPrice': 0.0,
              'totalPrice': 0.0,
              'status': 'performed',
              'version': 1,
            },
          ),
        ],
      ),
    });
    final service = PullSyncService(database: database, client: client);

    await service.pull(tenantId: DevelopmentSeed.tenantId);

    final catalog = await (database.select(
      database.tariffCatalogItems,
    )..where((table) => table.id.equals('tariff-cleaning'))).getSingle();
    final assignment = await (database.select(
      database.objectTariffAssignments,
    )..where((table) => table.id.equals('object-tariff-cleaning'))).getSingle();
    final serviceLine = await (database.select(
      database.workOrderServiceLines,
    )..where((table) => table.id.equals('service-line-cleaning'))).getSingle();

    expect(catalog.description, 'Reinigung / Kontrolle von:');
    expect(assignment.objectId, DevelopmentSeed.objectId);
    expect(assignment.tariffCatalogItemId, 'tariff-cleaning');
    expect(serviceLine.workOrderId, DevelopmentSeed.workOrderInspectionId);
    expect(serviceLine.objectTariffAssignmentId, 'object-tariff-cleaning');
    expect(client.requestedEntityTypes, contains('tariff_catalog_items'));
    expect(client.requestedEntityTypes, contains('object_tariff_assignments'));
    expect(client.requestedEntityTypes, contains('work_order_service_lines'));
  });

  test('downloads raw Genesis legacy records with payload JSON', () async {
    final client = _FakePullSyncClient({
      'legacy_import_records': const PullSyncPage(
        changes: [
          ServerEntityChange(
            entityType: 'legacy_import_record',
            data: {
              'id': 'legacy-rechzeile-1',
              'batchId': 'batch-1',
              'sourceSystem': 'genesis',
              'sourceFile': 'Daten/KFKRECH.MDB',
              'sourceTable': 'RechZeilen',
              'sourceKey': 'row:KFKRECH.RechZeilen:0:abc',
              'rowHash': 'abc',
              'rowIndex': 0,
              'recordType': 'row',
              'mappedEntityType': null,
              'mappedEntityId': null,
              'payloadJson':
                  '{"OPRechNr":123,"PossBez":"Amtliche Holzfeuerungskontrolle"}',
              'version': 1,
            },
          ),
        ],
      ),
    });
    final service = PullSyncService(database: database, client: client);

    await service.pull(tenantId: DevelopmentSeed.tenantId);

    final legacyRecord = await (database.select(
      database.legacyImportRecords,
    )..where((table) => table.id.equals('legacy-rechzeile-1'))).getSingle();

    expect(legacyRecord.sourceFile, 'Daten/KFKRECH.MDB');
    expect(legacyRecord.sourceTable, 'RechZeilen');
    expect(legacyRecord.payloadJson, contains('Holzfeuerungskontrolle'));
    expect(client.requestedEntityTypes, contains('legacy_import_records'));
  });

  test(
    'downloads tenant report templates for offline PDF generation',
    () async {
      final client = _FakePullSyncClient({
        'report_templates': const PullSyncPage(
          changes: [
            ServerEntityChange(
              entityType: 'report_template',
              data: {
                'id': 'remote-report-template',
                'name': 'Mandant Vorlage',
                'reportType': 'work_order',
                'titlePrefix': 'Serviceprotokoll',
                'locale': 'de',
                'primaryColor': '#0f766e',
                'footerText': 'Mandantenfooter',
                'includeCustomer': true,
                'includeInstallations': true,
                'includeMeasurements': false,
                'includeDefects': true,
                'includeMaterials': true,
                'includeTimeEntries': true,
                'includePhotos': false,
                'includeSignature': true,
                'isDefault': true,
                'version': 1,
              },
            ),
          ],
        ),
      });
      final service = PullSyncService(database: database, client: client);

      await service.pull(tenantId: DevelopmentSeed.tenantId);

      final template = await database.reportTemplateDao.getDefault(
        DevelopmentSeed.tenantId,
      );

      expect(template?.id, 'remote-report-template');
      expect(template?.titlePrefix, 'Serviceprotokoll');
      expect(template?.includeMeasurements, isFalse);
      expect(template?.includePhotos, isFalse);
      expect(client.requestedEntityTypes, contains('report_templates'));
    },
  );

  test(
    'marks conflict instead of overwriting unsynced local changes',
    () async {
      await database.customerDao.updateNotesLocal(
        id: DevelopmentSeed.customerId,
        notes: 'Lokale Notiz bleibt erhalten.',
      );
      final localCustomer = await database.customerDao.getById(
        DevelopmentSeed.customerId,
      );
      final client = _FakePullSyncClient({
        'customers': PullSyncPage(
          changes: [
            ServerEntityChange(
              entityType: 'customer',
              data: {
                ...localCustomer!.toJson(),
                'displayName': 'Server darf nicht ueberschreiben',
                'notes': 'Servernotiz',
                'syncStatus': 'synced',
                'version': localCustomer.version + 1,
              },
            ),
          ],
        ),
      });
      final service = PullSyncService(database: database, client: client);

      await service.pull(tenantId: DevelopmentSeed.tenantId);

      final customer = await database.customerDao.getById(
        DevelopmentSeed.customerId,
      );
      final outbox = await database.outboxDao
          .watchPending(DevelopmentSeed.tenantId)
          .first;

      expect(customer?.notes, 'Lokale Notiz bleibt erhalten.');
      expect(customer?.displayName, localCustomer.displayName);
      expect(customer?.syncStatus, 'conflict');
      expect(outbox.single.status, 'pending');
    },
  );

  test('DioPullSyncClient requests cursor and parses server payload', () async {
    final adapter = FakeHttpClientAdapter((options) {
      expect(options.path, '/sync/pull');
      expect(options.headers['Authorization'], 'Bearer sync-token');
      expect(options.queryParameters['tenantId'], DevelopmentSeed.tenantId);
      expect(options.queryParameters['entityType'], 'customers');
      expect(options.queryParameters['cursor'], 'cursor-1');
      return ResponseBody.fromString(
        jsonEncode({
          'nextCursor': 'cursor-2',
          'changes': [
            {
              'entityType': 'customer',
              'operation': 'upsert',
              'data': {'id': 'remote-customer-id'},
            },
          ],
        }),
        200,
        headers: jsonHeaders,
      );
    });
    final dio = Dio(BaseOptions(baseUrl: 'https://sync.test'));
    dio.httpClientAdapter = adapter;
    final client = DioPullSyncClient(
      ApiClient(
        environment: AppEnvironment.fromFlavor(
          AppFlavor.dev,
          apiBaseUrl: Uri.parse('https://sync.test'),
        ),
        dio: dio,
        accessTokenProvider: () => 'sync-token',
      ),
    );

    final page = await client.pull(
      tenantId: DevelopmentSeed.tenantId,
      entityType: 'customers',
      cursor: 'cursor-1',
    );

    expect(page.cursor, 'cursor-2');
    expect(page.changes.single.entityType, 'customer');
    expect(page.changes.single.operation, 'upsert');
    expect(page.changes.single.data['id'], 'remote-customer-id');
  });
}

final class _FakePullSyncClient implements PullSyncClient {
  _FakePullSyncClient(this._pages);

  final Map<String, PullSyncPage> _pages;
  final requestedEntityTypes = <String>[];

  @override
  Future<PullSyncPage> pull({
    required String tenantId,
    required String entityType,
    String? cursor,
  }) async {
    requestedEntityTypes.add(entityType);
    return _pages[entityType] ??
        PullSyncPage(changes: const [], cursor: cursor);
  }
}

final class _RecordingNotificationSink implements WorkOrderNotificationSink {
  final notifications = <NewWorkOrderNotification>[];

  @override
  Future<void> notifyNewWorkOrder(NewWorkOrderNotification notification) async {
    notifications.add(notification);
  }
}
