import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kaminfeger_mobile/data/db/app_database.dart';
import 'package:kaminfeger_mobile/data/repositories/drift_report_repository.dart';

void main() {
  late AppDatabase database;

  setUp(() async {
    database = AppDatabase.forTesting(NativeDatabase.memory());
    await database.seedDevelopmentData();
  });

  tearDown(() async {
    await database.close();
  });

  test('attaches saved signature metadata to the work order locally', () async {
    final signaturePhotoId = await database.photoDao.createLocal(
      tenantId: DevelopmentSeed.tenantId,
      workOrderId: DevelopmentSeed.workOrderInspectionId,
      localPath: '/tmp/customer-signature.png',
      fileName: 'customer-signature.png',
      mimeType: 'image/png',
      sizeBytes: 2048,
      caption: 'Signatur Anna Keller',
    );

    await database.workOrderDao.attachSignatureLocal(
      id: DevelopmentSeed.workOrderInspectionId,
      signatureFileId: signaturePhotoId,
    );

    final order = await database.workOrderDao.getById(
      DevelopmentSeed.workOrderInspectionId,
    );
    final pendingOutbox = await database.outboxDao
        .watchPending(DevelopmentSeed.tenantId)
        .first;

    expect(order?.customerSignatureFileId, signaturePhotoId);
    expect(order?.syncStatus, 'pending');
    expect(
      pendingOutbox.map((entry) => '${entry.entityType}:${entry.operation}'),
      containsAll(['photo:upload_file', 'work_order:update']),
    );
  });

  test(
    'creates signed report record with signer name and outbox upload',
    () async {
      final repository = DriftReportRepository(
        database: database,
        tenantId: DevelopmentSeed.tenantId,
      );

      final reportId = await repository.createGenerated(
        workOrderId: DevelopmentSeed.workOrderInspectionId,
        reportNumber: 'R-WO-2026-0001-signed',
        pdfLocalPath: '/tmp/signed-rapport.pdf',
        customerNameSigned: 'Anna Keller',
        signed: true,
      );

      final report =
          (await repository
                  .watchForWorkOrder(DevelopmentSeed.workOrderInspectionId)
                  .first)
              .single;
      final order = await database.workOrderDao.getById(
        DevelopmentSeed.workOrderInspectionId,
      );
      final pendingOutbox = await database.outboxDao
          .watchPending(DevelopmentSeed.tenantId)
          .first;

      expect(report.id, reportId);
      expect(report.status, 'signed');
      expect(report.signedAt, isNotNull);
      expect(report.customerNameSigned, 'Anna Keller');
      expect(order?.reportFileId, reportId);
      expect(
        pendingOutbox.map((entry) => '${entry.entityType}:${entry.operation}'),
        containsAll([
          'report:create',
          'report:upload_file',
          'work_order:update',
        ]),
      );
    },
  );
}
