import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kaminfeger_mobile/data/db/app_database.dart';
import 'package:kaminfeger_mobile/data/repositories/drift_checklist_repository.dart';
import 'package:kaminfeger_mobile/data/repositories/drift_defect_repository.dart';
import 'package:kaminfeger_mobile/data/repositories/drift_material_repository.dart';
import 'package:kaminfeger_mobile/data/repositories/drift_measurement_repository.dart';
import 'package:kaminfeger_mobile/data/repositories/drift_photo_repository.dart';
import 'package:kaminfeger_mobile/data/repositories/drift_report_repository.dart';
import 'package:kaminfeger_mobile/data/repositories/drift_time_entry_repository.dart';
import 'package:kaminfeger_mobile/data/repositories/drift_work_order_repository.dart';
import 'package:kaminfeger_mobile/data/sync/file_upload_sync_service.dart';
import 'package:kaminfeger_mobile/data/sync/outbox_processor.dart';
import 'package:kaminfeger_mobile/data/sync/push_sync_service.dart';
import 'package:kaminfeger_mobile/domain/entities/defect.dart';
import 'package:kaminfeger_mobile/domain/entities/material_usage.dart';
import 'package:kaminfeger_mobile/domain/entities/measurement.dart';
import 'package:kaminfeger_mobile/domain/entities/photo_attachment.dart';
import 'package:kaminfeger_mobile/domain/entities/time_entry.dart';
import 'package:kaminfeger_mobile/domain/enums/checklist_answer_type.dart';
import 'package:kaminfeger_mobile/domain/enums/work_order_status.dart';
import 'package:kaminfeger_mobile/domain/use_cases/save_measurement.dart';
import 'package:kaminfeger_mobile/domain/use_cases/start_work_order.dart';
import 'package:kaminfeger_mobile/domain/use_cases/validate_checklist.dart';

void main() {
  late AppDatabase database;

  setUp(() {
    database = AppDatabase.forTesting(NativeDatabase.memory());
  });

  tearDown(() async {
    await database.close();
  });

  test('seeds development work orders for the active day', () async {
    await database.seedDevelopmentData();

    final orders = await database.workOrderDao
        .watchToday(DevelopmentSeed.tenantId, DateTime.now())
        .first;

    expect(orders, hasLength(2));
    expect(
      orders.map((order) => order.orderNumber),
      containsAll(['WO-2026-0001', 'WO-2026-0002']),
    );
  });

  test(
    'start operation updates local record and enqueues outbox entry',
    () async {
      await database.seedDevelopmentData();
      final repository = DriftWorkOrderRepository(
        database: database,
        tenantId: DevelopmentSeed.tenantId,
        userId: DevelopmentSeed.technicianUserId,
      );
      final startWorkOrder = StartWorkOrder(repository);

      await startWorkOrder(DevelopmentSeed.workOrderInspectionId);

      final order = await database.workOrderDao.getById(
        DevelopmentSeed.workOrderInspectionId,
      );
      final pendingOutbox = await database.outboxDao
          .watchPending(DevelopmentSeed.tenantId)
          .first;

      expect(order, isNotNull);
      expect(order!.status, WorkOrderStatus.inProgress.value);
      expect(order.actualStart, isNotNull);
      expect(order.syncStatus, 'pending');
      expect(order.version, 2);
      expect(pendingOutbox, hasLength(2));
      expect(
        pendingOutbox.map((entry) => '${entry.entityType}:${entry.operation}'),
        containsAll(['work_order:update', 'time_entry:create']),
      );
    },
  );

  test(
    'detail stream joins work order, customer, object and installations',
    () async {
      await database.seedDevelopmentData();
      final repository = DriftWorkOrderRepository(
        database: database,
        tenantId: DevelopmentSeed.tenantId,
        userId: DevelopmentSeed.technicianUserId,
      );

      final detail = await repository
          .watchDetail(DevelopmentSeed.workOrderInspectionId)
          .first;

      expect(detail, isNotNull);
      expect(detail!.workOrder.orderNumber, 'WO-2026-0001');
      expect(detail.customer.displayName, 'Familie Keller');
      expect(detail.object.city, 'Uster');
      expect(detail.installations, hasLength(1));
      expect(detail.installations.single.displayName, 'Rueegg RIII 45');
    },
  );

  test('pause and complete close open time entries with duration', () async {
    await database.seedDevelopmentData();
    final repository = DriftWorkOrderRepository(
      database: database,
      tenantId: DevelopmentSeed.tenantId,
      userId: DevelopmentSeed.technicianUserId,
    );

    await repository.startWorkOrder(DevelopmentSeed.workOrderInspectionId);
    await repository.pauseWorkOrder(DevelopmentSeed.workOrderInspectionId);

    final timeEntriesAfterPause =
        await (database.select(database.timeEntries)..where(
              (table) => table.workOrderId.equals(
                DevelopmentSeed.workOrderInspectionId,
              ),
            ))
            .get();

    expect(timeEntriesAfterPause, hasLength(1));
    expect(timeEntriesAfterPause.single.endTime, isNotNull);
    expect(timeEntriesAfterPause.single.durationMinutes, isNotNull);

    await repository.resumeWorkOrder(DevelopmentSeed.workOrderInspectionId);
    await repository.completeWorkOrder(DevelopmentSeed.workOrderInspectionId);

    final completedOrder = await database.workOrderDao.getById(
      DevelopmentSeed.workOrderInspectionId,
    );
    final timeEntriesAfterComplete =
        await (database.select(database.timeEntries)..where(
              (table) => table.workOrderId.equals(
                DevelopmentSeed.workOrderInspectionId,
              ),
            ))
            .get();

    expect(completedOrder?.status, WorkOrderStatus.completed.value);
    expect(completedOrder?.actualEnd, isNotNull);
    expect(timeEntriesAfterComplete, hasLength(2));
    expect(
      timeEntriesAfterComplete.every((entry) => entry.endTime != null),
      isTrue,
    );
  });

  test(
    'creates checklist answers from template and autosaves updates',
    () async {
      await database.seedDevelopmentData();
      final repository = DriftChecklistRepository(
        database: database,
        tenantId: DevelopmentSeed.tenantId,
      );

      await repository.createFromTemplate(
        workOrderId: DevelopmentSeed.workOrderInspectionId,
        workOrderType: 'inspection',
      );

      final items = await repository
          .watchForWorkOrder(
            workOrderId: DevelopmentSeed.workOrderInspectionId,
            workOrderType: 'inspection',
          )
          .first;
      final firstRequired = items.first;

      expect(items, hasLength(6));
      expect(
        items.map((item) => item.item.answerType),
        containsAll(ChecklistAnswerType.values.take(6)),
      );
      expect(
        ValidateChecklist().call(items).missingRequired,
        contains(firstRequired.item.label),
      );

      await repository.saveAnswer(
        answerId: firstRequired.answer.id,
        answerValue: 'yes',
        comment: 'Sichtkontrolle ok',
        isOk: true,
      );

      final updated = await database.checklistDao.getAnswerById(
        firstRequired.answer.id,
      );
      final pendingOutbox = await database.outboxDao
          .watchPending(DevelopmentSeed.tenantId)
          .first;

      expect(updated?.answerValue, 'yes');
      expect(updated?.comment, 'Sichtkontrolle ok');
      expect(updated?.syncStatus, 'pending');
      expect(
        pendingOutbox.map((entry) => '${entry.entityType}:${entry.operation}'),
        containsAll(['checklist_answer:create', 'checklist_answer:update']),
      );
    },
  );

  test('creates local measurement and outbox entry', () async {
    await database.seedDevelopmentData();
    final repository = DriftMeasurementRepository(
      database: database,
      tenantId: DevelopmentSeed.tenantId,
    );
    final saveMeasurement = SaveMeasurement(repository);

    await saveMeasurement(
      const MeasurementDraft(
        workOrderId: DevelopmentSeed.workOrderInspectionId,
        installationId: DevelopmentSeed.installationId,
        type: MeasurementType.co,
        value: 18,
        unit: 'ppm',
        notes: 'Plausibel',
      ),
    );

    final measurements = await repository
        .watchForWorkOrder(DevelopmentSeed.workOrderInspectionId)
        .first;
    final pendingOutbox = await database.outboxDao
        .watchPending(DevelopmentSeed.tenantId)
        .first;

    expect(measurements, hasLength(1));
    expect(measurements.single.type, MeasurementType.co);
    expect(measurements.single.syncStatus, 'pending');
    expect(
      pendingOutbox.map((entry) => '${entry.entityType}:${entry.operation}'),
      contains('measurement:create'),
    );
  });

  test('creates and resolves defects offline', () async {
    await database.seedDevelopmentData();
    final repository = DriftDefectRepository(
      database: database,
      tenantId: DevelopmentSeed.tenantId,
    );

    await repository.create(
      const DefectDraft(
        workOrderId: DevelopmentSeed.workOrderInspectionId,
        installationId: DevelopmentSeed.installationId,
        severity: DefectSeverity.critical,
        title: 'Riss im Feuerraum',
        description: 'Sichtbarer Riss an der linken Seitenwand.',
        recommendedAction: 'Fachprüfung veranlassen',
      ),
    );

    final defects = await repository
        .watchForWorkOrder(DevelopmentSeed.workOrderInspectionId)
        .first;
    expect(defects, hasLength(1));
    expect(defects.single.isCritical, isTrue);
    expect(defects.single.syncStatus, 'pending');

    await repository.resolve(defects.single.id);

    final resolved = await repository
        .watchForWorkOrder(DevelopmentSeed.workOrderInspectionId)
        .first;
    final outbox = await database.outboxDao
        .watchPending(DevelopmentSeed.tenantId)
        .first;

    expect(resolved.single.resolved, isTrue);
    expect(
      outbox.map((entry) => '${entry.entityType}:${entry.operation}'),
      containsAll(['defect:create', 'defect:update']),
    );
  });

  test('creates time and material records with validation', () async {
    await database.seedDevelopmentData();
    final timeRepository = DriftTimeEntryRepository(
      database: database,
      tenantId: DevelopmentSeed.tenantId,
    );
    final materialRepository = DriftMaterialRepository(
      database: database,
      tenantId: DevelopmentSeed.tenantId,
    );

    await timeRepository.create(
      TimeEntryDraft(
        workOrderId: DevelopmentSeed.workOrderInspectionId,
        userId: DevelopmentSeed.technicianUserId,
        type: TimeEntryType.travel,
        startTime: DateTime.utc(2026, 1, 1, 8),
        endTime: DateTime.utc(2026, 1, 1, 8, 30),
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

    final times = await timeRepository
        .watchForWorkOrder(DevelopmentSeed.workOrderInspectionId)
        .first;
    final materials = await materialRepository
        .watchForWorkOrder(DevelopmentSeed.workOrderInspectionId)
        .first;

    expect(times.single.durationMinutes, 30);
    expect(materials.single.name, 'Dichtung');
    expect(materials.single.syncStatus, 'pending');
  });

  test('creates photo upload metadata and processes outbox sync', () async {
    await database.seedDevelopmentData();
    final repository = DriftPhotoRepository(
      database: database,
      tenantId: DevelopmentSeed.tenantId,
    );

    final id = await repository.create(
      const PhotoDraft(
        workOrderId: DevelopmentSeed.workOrderInspectionId,
        localPath: '/tmp/photo.jpg',
        fileName: 'photo.jpg',
        mimeType: 'image/jpeg',
        sizeBytes: 1024,
        caption: 'Dokumentation',
      ),
    );

    final beforeSync = await repository
        .watchForWorkOrder(DevelopmentSeed.workOrderInspectionId)
        .first;
    expect(beforeSync.single.id, id);
    expect(beforeSync.single.uploadStatus, 'pending');

    final processor = OutboxProcessor(
      database: database,
      pushSyncService: const PushSyncService(),
      fileUploadSyncService: FileUploadSyncService(database: database),
    );
    final processed = await processor.process(
      tenantId: DevelopmentSeed.tenantId,
    );
    final outbox = await database.outboxDao
        .watchPending(DevelopmentSeed.tenantId)
        .first;
    final afterSync = await database.photoDao.getById(id);

    expect(processed, 1);
    expect(outbox, isEmpty);
    expect(afterSync?.uploadStatus, 'uploaded');
    expect(afterSync?.syncStatus, 'synced');
  });

  test('creates generated report record and links it to work order', () async {
    await database.seedDevelopmentData();
    final repository = DriftReportRepository(
      database: database,
      tenantId: DevelopmentSeed.tenantId,
    );

    final id = await repository.createGenerated(
      workOrderId: DevelopmentSeed.workOrderInspectionId,
      reportNumber: 'R-WO-2026-0001',
      pdfLocalPath: '/tmp/rapport.pdf',
      signed: false,
    );

    final reports = await repository
        .watchForWorkOrder(DevelopmentSeed.workOrderInspectionId)
        .first;
    final order = await database.workOrderDao.getById(
      DevelopmentSeed.workOrderInspectionId,
    );
    final outbox = await database.outboxDao
        .watchPending(DevelopmentSeed.tenantId)
        .first;

    expect(reports.single.id, id);
    expect(order?.reportFileId, id);
    expect(
      outbox.map((entry) => '${entry.entityType}:${entry.operation}'),
      containsAll(['report:create', 'work_order:update']),
    );
  });

  test(
    'soft delete hides record from active queries and creates delete outbox',
    () async {
      await database.seedDevelopmentData();

      await database.workOrderDao.softDeleteLocal(
        DevelopmentSeed.workOrderInspectionId,
      );

      final activeOrders = await database.workOrderDao
          .watchActive(DevelopmentSeed.tenantId)
          .first;
      final deletedOrder = await database.workOrderDao.getById(
        DevelopmentSeed.workOrderInspectionId,
      );
      final pendingOutbox = await database.outboxDao
          .watchPending(DevelopmentSeed.tenantId)
          .first;

      expect(
        activeOrders.map((order) => order.id),
        isNot(contains(DevelopmentSeed.workOrderInspectionId)),
      );
      expect(deletedOrder?.deletedAt, isNotNull);
      expect(pendingOutbox.single.operation, 'delete');
    },
  );
}
