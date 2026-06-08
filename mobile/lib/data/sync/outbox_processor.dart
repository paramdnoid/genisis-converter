import '../db/app_database.dart';
import 'file_upload_sync_service.dart';
import 'push_sync_service.dart';

final class OutboxProcessor {
  const OutboxProcessor({
    required this.database,
    required this.pushSyncService,
    required this.fileUploadSyncService,
  });

  final AppDatabase database;
  final PushSyncService pushSyncService;
  final FileUploadSyncService fileUploadSyncService;

  Future<int> process({required String tenantId}) async {
    final entries = await database.outboxDao.listPending(tenantId);
    var processed = 0;

    for (final entry in entries) {
      try {
        await database.outboxDao.markProcessing(entry.id);
        if (entry.operation == 'upload_file') {
          await fileUploadSyncService.upload(entry);
        } else {
          await pushSyncService.push(entry);
        }
        await database.setEntitySyncStatus(
          entityType: entry.entityType,
          entityId: entry.entityId,
          syncStatus: 'synced',
        );
        await database.outboxDao.markDone(entry.id);
        processed += 1;
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
