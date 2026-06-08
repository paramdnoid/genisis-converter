import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kaminfeger_mobile/data/db/app_database.dart';
import 'package:kaminfeger_mobile/data/sync/file_upload_sync_service.dart';
import 'package:kaminfeger_mobile/data/sync/outbox_processor.dart';
import 'package:kaminfeger_mobile/data/sync/push_sync_service.dart';

void main() {
  late AppDatabase database;

  setUp(() {
    database = AppDatabase.forTesting(NativeDatabase.memory());
  });

  tearDown(() async {
    await database.close();
  });

  test('failed photo upload remains retryable and not uploaded', () async {
    await database.seedDevelopmentData();
    final photoId = await _createPendingPhoto(database);
    final processor = OutboxProcessor(
      database: database,
      pushSyncService: const PushSyncService(),
      fileUploadSyncService: FileUploadSyncService(
        database: database,
        handler: (_) async => throw StateError('upload failed'),
      ),
    );

    final processed = await processor.process(
      tenantId: DevelopmentSeed.tenantId,
    );

    final photo = await database.photoDao.getById(photoId);
    final pendingOutbox = await database.outboxDao
        .watchPending(DevelopmentSeed.tenantId)
        .first;

    expect(processed, 0);
    expect(photo?.uploadStatus, 'pending');
    expect(photo?.remoteUrl, isNull);
    expect(photo?.syncStatus, 'failed');
    expect(pendingOutbox, hasLength(1));
    expect(pendingOutbox.single.operation, 'upload_file');
    expect(pendingOutbox.single.status, 'failed');
    expect(pendingOutbox.single.syncStatus, 'failed');
    expect(pendingOutbox.single.attempts, 1);
    expect(pendingOutbox.single.errorMessage, contains('upload failed'));
  });

  test(
    'failed photo upload respects retry backoff before succeeding',
    () async {
      await database.seedDevelopmentData();
      final photoId = await _createPendingPhoto(database);
      final failingProcessor = OutboxProcessor(
        database: database,
        pushSyncService: const PushSyncService(),
        fileUploadSyncService: FileUploadSyncService(
          database: database,
          handler: (_) async => throw StateError('temporary upload outage'),
        ),
      );

      await failingProcessor.process(tenantId: DevelopmentSeed.tenantId);

      final failedEntry =
          (await database.outboxDao
                  .watchPending(DevelopmentSeed.tenantId)
                  .first)
              .single;
      await database
          .update(database.outboxEntries)
          .replace(
            failedEntry.copyWith(
              lastAttemptAt: Value(DateTime.utc(2026).toIso8601String()),
            ),
          );

      final waitingProcessor = OutboxProcessor(
        database: database,
        pushSyncService: const PushSyncService(),
        fileUploadSyncService: FileUploadSyncService(database: database),
        retryBackoffPolicy: const RetryBackoffPolicy(
          baseDelay: Duration(minutes: 1),
        ),
        clock: () => DateTime.utc(2026, 1, 1, 0, 1),
      );
      final processedEarly = await waitingProcessor.process(
        tenantId: DevelopmentSeed.tenantId,
      );
      final stillPendingPhoto = await database.photoDao.getById(photoId);
      final stillPendingOutbox = await database.outboxDao
          .watchPending(DevelopmentSeed.tenantId)
          .first;

      final readyProcessor = OutboxProcessor(
        database: database,
        pushSyncService: const PushSyncService(),
        fileUploadSyncService: FileUploadSyncService(database: database),
        retryBackoffPolicy: const RetryBackoffPolicy(
          baseDelay: Duration(minutes: 1),
        ),
        clock: () => DateTime.utc(2026, 1, 1, 0, 3),
      );
      final processedLater = await readyProcessor.process(
        tenantId: DevelopmentSeed.tenantId,
      );
      final uploadedPhoto = await database.photoDao.getById(photoId);
      final remainingOutbox = await database.outboxDao
          .watchPending(DevelopmentSeed.tenantId)
          .first;

      expect(processedEarly, 0);
      expect(stillPendingPhoto?.uploadStatus, 'pending');
      expect(stillPendingPhoto?.syncStatus, 'failed');
      expect(stillPendingOutbox.single.status, 'failed');
      expect(processedLater, 1);
      expect(uploadedPhoto?.uploadStatus, 'uploaded');
      expect(uploadedPhoto?.remoteUrl, 'pending-server-url/$photoId');
      expect(uploadedPhoto?.syncStatus, 'synced');
      expect(remainingOutbox, isEmpty);
    },
  );
}

Future<String> _createPendingPhoto(AppDatabase database) {
  return database.photoDao.createLocal(
    tenantId: DevelopmentSeed.tenantId,
    workOrderId: DevelopmentSeed.workOrderInspectionId,
    localPath: '/tmp/upload-failure-photo.jpg',
    fileName: 'upload-failure-photo.jpg',
    mimeType: 'image/jpeg',
    sizeBytes: 2048,
    caption: 'Upload failure regression',
  );
}
