import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/config/environment_providers.dart';
import '../api/api_client.dart';
import '../db/database_providers.dart';
import '../../features/work_orders/application/work_order_providers.dart';
import 'file_upload_sync_service.dart';
import 'network_monitor.dart';
import 'outbox_processor.dart';
import 'pull_sync_service.dart';
import 'push_sync_service.dart';
import 'sync_orchestrator.dart';
import 'sync_service.dart';

final networkMonitorProvider = Provider<NetworkMonitor>((ref) {
  return NetworkMonitor();
});

final syncOrchestratorProvider = FutureProvider<SyncOrchestrator>((ref) async {
  final database = await ref.watch(databaseReadyProvider.future);
  final tenantId = ref.watch(activeTenantIdProvider);
  final environment = ref.watch(appEnvironmentProvider);
  final orchestrator = SyncOrchestrator(
    database: database,
    tenantId: tenantId,
    networkMonitor: ref.watch(networkMonitorProvider),
    pullSyncService: PullSyncService(
      database: database,
      client: DioPullSyncClient(ApiClient(environment: environment)),
    ),
    outboxProcessor: OutboxProcessor(
      database: database,
      pushSyncService: const PushSyncService(),
      fileUploadSyncService: FileUploadSyncService(database: database),
    ),
  );
  ref.onDispose(() {
    unawaited(orchestrator.dispose());
  });
  return orchestrator;
});

final syncServiceProvider = FutureProvider<SyncService>((ref) async {
  final orchestrator = await ref.watch(syncOrchestratorProvider.future);
  return SyncService(orchestrator);
});

final syncNowProvider = FutureProvider.autoDispose<SyncSummary>((ref) async {
  final service = await ref.watch(syncServiceProvider.future);
  return service.syncNow();
});

final syncBootstrapProvider = FutureProvider<void>((ref) async {
  final service = await ref.watch(syncServiceProvider.future);
  service.startAutoSync();
});
