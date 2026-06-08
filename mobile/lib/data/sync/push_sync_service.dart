import '../db/app_database.dart';

typedef PushSyncHandler = Future<PushSyncResult> Function(OutboxEntryRow entry);

final class PushSyncResult {
  const PushSyncResult.accepted()
    : isAccepted = true,
      isConflict = false,
      message = null;

  const PushSyncResult.conflict([this.message])
    : isAccepted = false,
      isConflict = true;

  final bool isAccepted;
  final bool isConflict;
  final String? message;
}

final class PushSyncService {
  const PushSyncService({this.handler});

  final PushSyncHandler? handler;

  Future<PushSyncResult> push(OutboxEntryRow entry) async {
    final customHandler = handler;
    if (customHandler != null) {
      return customHandler(entry);
    }

    if (entry.payloadJson.trim().isEmpty) {
      throw StateError('Outbox payload is empty.');
    }
    return const PushSyncResult.accepted();
  }
}
