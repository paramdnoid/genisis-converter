import '../db/app_database.dart';

final class FileUploadSyncService {
  const FileUploadSyncService({required this.database});

  final AppDatabase database;

  Future<void> upload(OutboxEntryRow entry) async {
    if (entry.entityType == 'photo') {
      await database.markPhotoUploaded(
        entry.entityId,
        remoteUrl: 'pending-server-url/${entry.entityId}',
      );
      return;
    }

    if (entry.entityType == 'report') {
      await database.markReportUploaded(
        entry.entityId,
        remoteUrl: 'pending-server-report-url/${entry.entityId}',
      );
    }
  }
}
