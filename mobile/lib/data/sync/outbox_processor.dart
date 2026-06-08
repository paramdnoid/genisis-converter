import '../../core/errors/app_error.dart';
import '../db/app_database.dart';
import 'file_upload_sync_service.dart';
import 'push_sync_service.dart';

final class RetryBackoffPolicy {
  const RetryBackoffPolicy({
    this.baseDelay = const Duration(minutes: 1),
    this.maxExponent = 5,
  });

  final Duration baseDelay;
  final int maxExponent;

  bool isReady(OutboxEntryRow entry, DateTime now) {
    if (entry.status != 'failed') {
      return entry.status == 'pending';
    }
    final lastAttempt = entry.lastAttemptAt == null
        ? null
        : DateTime.tryParse(entry.lastAttemptAt!);
    if (lastAttempt == null || entry.attempts <= 0) {
      return true;
    }
    return !lastAttempt.add(delayForAttempts(entry.attempts)).isAfter(now);
  }

  Duration delayForAttempts(int attempts) {
    final exponent = attempts.clamp(0, maxExponent);
    return Duration(milliseconds: baseDelay.inMilliseconds * (1 << exponent));
  }
}

final class OutboxProcessor {
  const OutboxProcessor({
    required this.database,
    required this.pushSyncService,
    required this.fileUploadSyncService,
    this.retryBackoffPolicy = const RetryBackoffPolicy(),
    this.clock,
  });

  final AppDatabase database;
  final PushSyncService pushSyncService;
  final FileUploadSyncService fileUploadSyncService;
  final RetryBackoffPolicy retryBackoffPolicy;
  final DateTime Function()? clock;

  Future<int> process({required String tenantId}) async {
    final entries = await database.outboxDao.listPending(tenantId);
    var processed = 0;
    final now = (clock ?? DateTime.now).call().toUtc();

    for (final entry in entries) {
      if (!retryBackoffPolicy.isReady(entry, now)) {
        continue;
      }

      try {
        await database.outboxDao.markProcessing(entry.id);
        if (entry.operation == 'upload_file') {
          await fileUploadSyncService.upload(entry);
        } else {
          final result = await pushSyncService.push(entry);
          if (result.isConflict) {
            throw SyncConflictError(
              message: result.message ?? 'Synchronization conflict detected.',
              metadata: {
                'entityType': entry.entityType,
                'entityId': entry.entityId,
              },
            );
          }
          if (!result.isAccepted) {
            throw StateError('Push entry was not accepted.');
          }
        }
        await database.setEntitySyncStatus(
          entityType: entry.entityType,
          entityId: entry.entityId,
          syncStatus: 'synced',
        );
        await database.outboxDao.markDone(entry.id);
        processed += 1;
      } on SyncConflictError catch (error) {
        await database.setEntitySyncStatus(
          entityType: entry.entityType,
          entityId: entry.entityId,
          syncStatus: 'conflict',
        );
        await database.outboxDao.markConflict(entry.id, error.message);
      } catch (error) {
        await database.setEntitySyncStatus(
          entityType: entry.entityType,
          entityId: entry.entityId,
          syncStatus: 'failed',
        );
        await database.outboxDao.markFailed(entry.id, error.toString());
      }
    }

    return processed;
  }
}
