import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kaminfeger_mobile/data/db/app_database.dart';
import 'package:kaminfeger_mobile/data/repositories/drift_defect_repository.dart';
import 'package:kaminfeger_mobile/data/repositories/drift_material_repository.dart';
import 'package:kaminfeger_mobile/data/repositories/drift_measurement_repository.dart';
import 'package:kaminfeger_mobile/data/repositories/drift_photo_repository.dart';
import 'package:kaminfeger_mobile/data/repositories/drift_time_entry_repository.dart';
import 'package:kaminfeger_mobile/domain/entities/defect.dart';
import 'package:kaminfeger_mobile/domain/entities/material_usage.dart';
import 'package:kaminfeger_mobile/domain/entities/measurement.dart';
import 'package:kaminfeger_mobile/domain/entities/photo_attachment.dart';
import 'package:kaminfeger_mobile/domain/entities/time_entry.dart';
import 'package:kaminfeger_mobile/features/reports/application/report_data_aggregator.dart';

void main() {
  late AppDatabase database;

  setUp(() async {
    database = AppDatabase.forTesting(NativeDatabase.memory());
    await database.seedDevelopmentData();
  });

  tearDown(() async {
    await database.close();
  });

  test('loads full local report payload for a work order', () async {
    final measurementRepository = DriftMeasurementRepository(
      database: database,
      tenantId: DevelopmentSeed.tenantId,
    );
    final defectRepository = DriftDefectRepository(
      database: database,
      tenantId: DevelopmentSeed.tenantId,
    );
    final photoRepository = DriftPhotoRepository(
      database: database,
      tenantId: DevelopmentSeed.tenantId,
    );
    final timeRepository = DriftTimeEntryRepository(
      database: database,
      tenantId: DevelopmentSeed.tenantId,
    );
    final materialRepository = DriftMaterialRepository(
      database: database,
      tenantId: DevelopmentSeed.tenantId,
    );

    await measurementRepository.create(
      const MeasurementDraft(
        workOrderId: DevelopmentSeed.workOrderInspectionId,
        installationId: DevelopmentSeed.installationId,
        type: MeasurementType.co,
        value: 18,
        unit: 'ppm',
        notes: 'Plausibel',
      ),
    );
    await defectRepository.create(
      const DefectDraft(
        workOrderId: DevelopmentSeed.workOrderInspectionId,
        installationId: DevelopmentSeed.installationId,
        severity: DefectSeverity.major,
        title: 'Riss im Feuerraum',
        description: 'Sichtbarer Riss links.',
      ),
    );
    final photoId = await photoRepository.create(
      const PhotoDraft(
        workOrderId: DevelopmentSeed.workOrderInspectionId,
        objectId: DevelopmentSeed.objectId,
        installationId: DevelopmentSeed.installationId,
        localPath: '/tmp/report-photo.jpg',
        fileName: 'report-photo.jpg',
        mimeType: 'image/jpeg',
        sizeBytes: 1024,
        caption: 'Feuerraum',
      ),
    );
    final signatureId = await photoRepository.create(
      const PhotoDraft(
        workOrderId: DevelopmentSeed.workOrderInspectionId,
        localPath: '/tmp/signature.png',
        fileName: 'signature.png',
        mimeType: 'image/png',
        sizeBytes: 2048,
        caption: 'Signatur Anna Keller',
      ),
    );
    await database.workOrderDao.attachSignatureLocal(
      id: DevelopmentSeed.workOrderInspectionId,
      signatureFileId: signatureId,
    );
    await timeRepository.create(
      TimeEntryDraft(
        workOrderId: DevelopmentSeed.workOrderInspectionId,
        userId: DevelopmentSeed.technicianUserId,
        type: TimeEntryType.work,
        startTime: DateTime.utc(2026, 1, 1, 8),
        endTime: DateTime.utc(2026, 1, 1, 9),
      ),
    );
    await materialRepository.createUsage(
      const WorkOrderMaterialDraft(
        workOrderId: DevelopmentSeed.workOrderInspectionId,
        name: 'Dichtung',
        quantity: 2,
        unit: 'Stueck',
      ),
    );

    final data = await ReportDataAggregator(
      database: database,
      tenantId: DevelopmentSeed.tenantId,
    ).load(DevelopmentSeed.workOrderInspectionId);

    expect(data, isNotNull);
    expect(data!.tenant.name, 'Kaminfeger Muster AG');
    expect(data.header.workOrder.orderNumber, 'WO-2026-0001');
    expect(data.header.customer.displayName, 'Familie Keller');
    expect(data.header.object.name, 'Einfamilienhaus Keller');
    expect(
      data.installations.map((row) => row.id),
      contains(DevelopmentSeed.installationId),
    );
    expect(data.measurements.single.measurementType, 'co');
    expect(data.defects.single.title, 'Riss im Feuerraum');
    expect(
      data.photos.map((row) => row.id),
      containsAll([photoId, signatureId]),
    );
    expect(data.signaturePhoto?.id, signatureId);
    expect(data.timeEntries.single.durationMinutes, 60);
    expect(data.materials.single.name, 'Dichtung');
  });

  test('returns null when work order or tenant is missing', () async {
    final missingWorkOrder = await ReportDataAggregator(
      database: database,
      tenantId: DevelopmentSeed.tenantId,
    ).load('missing-work-order');
    final missingTenant = await ReportDataAggregator(
      database: database,
      tenantId: 'missing-tenant',
    ).load(DevelopmentSeed.workOrderInspectionId);

    expect(missingWorkOrder, isNull);
    expect(missingTenant, isNull);
  });
}
