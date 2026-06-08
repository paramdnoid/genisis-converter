import 'dart:async';

import 'package:connectivity_plus_platform_interface/connectivity_plus_platform_interface.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kaminfeger_mobile/data/db/app_database.dart';
import 'package:kaminfeger_mobile/data/sync/file_upload_sync_service.dart';
import 'package:kaminfeger_mobile/data/sync/network_monitor.dart';
import 'package:kaminfeger_mobile/data/sync/outbox_processor.dart';
import 'package:kaminfeger_mobile/data/sync/pull_sync_service.dart';
import 'package:kaminfeger_mobile/data/sync/push_sync_service.dart';
import 'package:kaminfeger_mobile/data/sync/sync_orchestrator.dart';

void main() {
  late AppDatabase database;
  late ConnectivityPlatform originalConnectivityPlatform;

  setUp(() {
    database = AppDatabase.forTesting(NativeDatabase.memory());
    originalConnectivityPlatform = ConnectivityPlatform.instance;
    ConnectivityPlatform.instance = _OfflineConnectivityPlatform();
  });

  tearDown(() async {
    ConnectivityPlatform.instance = originalConnectivityPlatform;
    await database.close();
  });

  test('syncNow is a no-op when connectivity reports offline', () async {
    await database.seedDevelopmentData();
    await database.customerDao.updateNotesLocal(
      id: DevelopmentSeed.customerId,
      notes: 'Offline erfasste Notiz',
    );

    final orchestrator = SyncOrchestrator(
      database: database,
      tenantId: DevelopmentSeed.tenantId,
      networkMonitor: NetworkMonitor(),
      pullSyncService: PullSyncService(database: database),
      outboxProcessor: OutboxProcessor(
        database: database,
        pushSyncService: const PushSyncService(),
        fileUploadSyncService: FileUploadSyncService(database: database),
      ),
    );

    final summary = await orchestrator.syncNow();

    final customer = await database.customerDao.getById(
      DevelopmentSeed.customerId,
    );
    final pendingOutbox = await database.outboxDao
        .watchPending(DevelopmentSeed.tenantId)
        .first;
    final syncStates = await database.syncStateDao
        .watchForTenant(DevelopmentSeed.tenantId)
        .first;

    expect(summary.wasOnline, isFalse);
    expect(summary.processedOutboxEntries, 0);
    expect(customer?.syncStatus, 'pending');
    expect(pendingOutbox, hasLength(1));
    expect(pendingOutbox.single.status, 'pending');
    expect(pendingOutbox.single.syncStatus, 'pending');
    expect(
      pendingOutbox.map((entry) => entry.status),
      isNot(containsAll(['failed', 'processing', 'done', 'conflict'])),
    );
    expect(syncStates.single.lastPullAt, isNull);
    expect(syncStates.single.lastSuccessfulSyncAt, isNull);
  });
}

final class _OfflineConnectivityPlatform extends ConnectivityPlatform {
  @override
  Future<List<ConnectivityResult>> checkConnectivity() async {
    return [ConnectivityResult.none];
  }

  @override
  Stream<List<ConnectivityResult>> get onConnectivityChanged {
    return Stream.value([ConnectivityResult.none]);
  }
}
