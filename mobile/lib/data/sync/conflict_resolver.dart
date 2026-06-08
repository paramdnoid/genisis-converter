import '../../core/errors/app_error.dart';

enum ConflictDecision { serverWins, localWins, createNewVersion }

final class ConflictResolver {
  const ConflictResolver();

  ConflictDecision resolve({
    required String entityType,
    required String operation,
  }) {
    return switch (entityType) {
      'measurement' || 'photo' => ConflictDecision.localWins,
      'report' => ConflictDecision.createNewVersion,
      'work_order' when operation == 'delete' => ConflictDecision.serverWins,
      _ => ConflictDecision.serverWins,
    };
  }

  SyncConflictError asError(String entityType) {
    return SyncConflictError(metadata: {'entityType': entityType});
  }
}
