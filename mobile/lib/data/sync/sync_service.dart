import 'sync_orchestrator.dart';

final class SyncService {
  const SyncService(this._orchestrator);

  final SyncOrchestrator _orchestrator;

  Future<SyncSummary> syncNow() {
    return _orchestrator.syncNow();
  }

  void startAutoSync() {
    _orchestrator.startAutoSync();
  }
}
