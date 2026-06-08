import '../db/app_database.dart';

typedef FileUploadSyncHandler = Future<void> Function(OutboxEntryRow entry);

final class FileUploadSyncService {
  const FileUploadSyncService({required this.database, this.handler});

  final AppDatabase database;
  final FileUploadSyncHandler? handler;

  Future<void> upload(OutboxEntryRow entry) async {
    final customHandler = handler;
    if (customHandler != null) {
      await customHandler(entry);
      return;
    }

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
