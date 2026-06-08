import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kaminfeger_mobile/data/db/app_database.dart';
import 'package:kaminfeger_mobile/data/repositories/drift_installation_repository.dart';

void main() {
  late AppDatabase database;
  late DriftInstallationRepository repository;

  setUp(() async {
    database = AppDatabase.forTesting(NativeDatabase.memory());
    await database.seedDevelopmentData();
    repository = DriftInstallationRepository(
      database: database,
      tenantId: DevelopmentSeed.tenantId,
    );
  });

  tearDown(() async {
    await database.close();
  });

  test('exposes active installations from local database', () async {
    final installations = await repository.watchAll().first;

    expect(
      installations.map((installation) => installation.displayName),
      contains('Rueegg RIII 45'),
    );
    expect(
      installations.map((installation) => installation.objectId),
      contains(DevelopmentSeed.objectId),
    );
  });

  test('loads installation detail aggregate with history and photos', () async {
    final photoId = await database.photoDao.createLocal(
      tenantId: DevelopmentSeed.tenantId,
      workOrderId: DevelopmentSeed.workOrderInspectionId,
      objectId: DevelopmentSeed.objectId,
      installationId: DevelopmentSeed.installationId,
      localPath: '/tmp/installation-photo.jpg',
      fileName: 'installation-photo.jpg',
      mimeType: 'image/jpeg',
      sizeBytes: 4096,
      caption: 'Feuerraum vor Reinigung',
    );

    final detail = await repository.getDetail(DevelopmentSeed.installationId);

    expect(detail, isNotNull);
    expect(detail!.installation.displayName, 'Rueegg RIII 45');
    expect(
      detail.history.map((order) => order.orderNumber),
      contains('WO-2026-0001'),
    );
    expect(detail.photos.map((photo) => photo.id), contains(photoId));
    expect(detail.photos.single.caption, 'Feuerraum vor Reinigung');
  });

  test('note updates stay local and enqueue outbox entry', () async {
    await repository.updateNotes(
      id: DevelopmentSeed.installationId,
      notes: 'Keramikplatten bei naechstem Besuch pruefen.',
    );

    final installation = await repository.getById(
      DevelopmentSeed.installationId,
    );
    final pendingOutbox = await database.outboxDao
        .watchPending(DevelopmentSeed.tenantId)
        .first;

    expect(installation?.notes, 'Keramikplatten bei naechstem Besuch pruefen.');
    expect(pendingOutbox, hasLength(1));
    expect(pendingOutbox.single.entityType, 'installation');
    expect(pendingOutbox.single.operation, 'update');
  });
}
