import '../db/app_database.dart';

final class PushSyncResult {
  const PushSyncResult.accepted();
}

final class PushSyncService {
  const PushSyncService();

  Future<PushSyncResult> push(OutboxEntryRow entry) async {
    if (entry.payloadJson.trim().isEmpty) {
      throw StateError('Outbox payload is empty.');
    }
    return const PushSyncResult.accepted();
  }
}
