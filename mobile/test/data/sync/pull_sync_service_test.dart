import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kaminfeger_mobile/core/config/app_environment.dart';
import 'package:kaminfeger_mobile/data/api/api_client.dart';
import 'package:kaminfeger_mobile/data/db/app_database.dart';
import 'package:kaminfeger_mobile/data/sync/pull_sync_service.dart';

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
