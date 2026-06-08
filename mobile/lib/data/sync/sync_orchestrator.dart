import 'dart:async';

import '../../core/errors/app_error.dart';
import '../db/app_database.dart';
import 'network_monitor.dart';
import 'outbox_processor.dart';
import 'pull_sync_service.dart';

final class SyncSummary {
  const SyncSummary({
    required this.processedOutboxEntries,
    required this.wasOnline,
  });

  final int processedOutboxEntries;
  final bool wasOnline;
}

final class SyncOrchestrator {
  SyncOrchestrator({
    required this.database,
    required this.tenantId,
    required this.networkMonitor,
    required this.pullSyncService,
    required this.outboxProcessor,
  });

  final AppDatabase database;
  final String tenantId;
  final NetworkMonitor networkMonitor;
  final PullSyncService pullSyncService;
  final OutboxProcessor outboxProcessor;

  Timer? _retryTimer;
  StreamSubscription<bool>? _networkSubscription;

  Future<SyncSummary> syncNow() async {
    final online = await networkMonitor.checkNow();
    if (!online) {
      return const SyncSummary(processedOutboxEntries: 0, wasOnline: false);
    }

    try {
      await pullSyncService.pull(tenantId: tenantId);
      final processed = await outboxProcessor.process(tenantId: tenantId);
      return SyncSummary(processedOutboxEntries: processed, wasOnline: true);
    } on AppError {
      rethrow;
    } catch (error, stackTrace) {
      throw UnexpectedError(cause: error, stackTrace: stackTrace);
    }
  }

  void startAutoSync() {
    _networkSubscription ??= networkMonitor.isOnline.listen((online) {
      if (online) {
        unawaited(syncNow());
      }
    });
    _retryTimer ??= Timer.periodic(const Duration(minutes: 5), (_) {
      unawaited(syncNow());
    });
    unawaited(syncNow());
  }

  Future<void> dispose() async {
    _retryTimer?.cancel();
    _retryTimer = null;
    await _networkSubscription?.cancel();
    _networkSubscription = null;
  }
}
