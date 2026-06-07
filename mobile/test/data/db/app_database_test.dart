import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kaminfeger_mobile/data/db/app_database.dart';
import 'package:kaminfeger_mobile/data/repositories/drift_checklist_repository.dart';
import 'package:kaminfeger_mobile/data/repositories/drift_measurement_repository.dart';
import 'package:kaminfeger_mobile/data/repositories/drift_work_order_repository.dart';
import 'package:kaminfeger_mobile/domain/entities/measurement.dart';
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
