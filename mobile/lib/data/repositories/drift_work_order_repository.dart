import 'dart:async';

import '../../domain/entities/installation.dart';
import '../../domain/entities/recurring_work_order_candidate.dart';
import '../../domain/entities/work_order.dart';
import '../../domain/entities/work_order_detail.dart';
import '../../domain/entities/work_order_route_stop.dart';
import '../../domain/entities/work_order_service.dart';
import '../../domain/repositories/work_order_repository.dart';
import '../db/app_database.dart';
import 'drift_entity_mappers.dart';

final class DriftWorkOrderRepository implements WorkOrderRepository {
  const DriftWorkOrderRepository({
    required this.database,
    required this.tenantId,
    required this.userId,
  });

  final AppDatabase database;
  final String tenantId;
  final String userId;

  @override
  Stream<List<WorkOrder>> watchAll() {
    return database.workOrderDao.watchActive(tenantId).map(_mapRows);
  }

  @override
  Stream<List<WorkOrder>> watchToday(DateTime day) {
    return database.workOrderDao.watchToday(tenantId, day).map(_mapRows);
  }

  @override
  Stream<List<WorkOrderRouteStop>> watchTodayRouteStops(DateTime day) {
    return database.workOrderDao
        .watchTodayRouteStops(tenantId, day)
        .map(
          (rows) => rows
              .map(
                (row) => WorkOrderRouteStop(
                  workOrder: mapWorkOrderRow(row.workOrder),
                  object: mapCustomerObjectRow(row.object),
                ),
              )
              .toList(growable: false),
        );
  }

  @override
  Stream<List<RecurringWorkOrderCandidate>> watchDueRecurringCandidates(
    DateTime dueOn,
  ) {
    return database.workOrderDao
        .watchDueRecurringCandidates(tenantId, dueOn)
        .map(
          (rows) => rows
              .map(
                (row) => RecurringWorkOrderCandidate(
                  installation: mapInstallationRow(row.installation),
                  object: mapCustomerObjectRow(row.object),
                  customer: mapCustomerRow(row.customer),
                ),
              )
              .toList(growable: false),
        );
  }

  @override
  Stream<WorkOrderDetail?> watchDetail(String id) {
    late StreamSubscription<WorkOrderDetailHeaderRow?> headerSubscription;
    StreamSubscription<List<InstallationRow>>? installationSubscription;
    StreamSubscription<List<ObjectTariffAssignmentRow>>? tariffSubscription;
    StreamSubscription<List<WorkOrderServiceLineRow>>? serviceLineSubscription;

    final controller = StreamController<WorkOrderDetail?>();
    WorkOrderDetailHeaderRow? header;
    List<Installation> installations = const [];
    List<ObjectTariffAssignment> availableTariffs = const [];
    List<WorkOrderServiceLine> serviceLines = const [];
    var installationsReady = false;
    var tariffsReady = false;
    var serviceLinesReady = false;

    void emit() {
      final currentHeader = header;
      if (currentHeader == null) {
        controller.add(null);
        return;
      }
      if (!installationsReady || !tariffsReady || !serviceLinesReady) {
        return;
      }

      controller.add(
        WorkOrderDetail(
          workOrder: mapWorkOrderRow(currentHeader.workOrder),
          customer: mapCustomerRow(currentHeader.customer),
          object: mapCustomerObjectRow(currentHeader.object),
          installations: installations,
          availableTariffs: availableTariffs,
          serviceLines: serviceLines,
        ),
      );
    }

    controller.onListen = () {
      headerSubscription = database.workOrderDao
          .watchDetailHeader(tenantId, id)
          .listen((nextHeader) {
            header = nextHeader;
            installationSubscription?.cancel();
            tariffSubscription?.cancel();
            serviceLineSubscription?.cancel();
            installations = const [];
            availableTariffs = const [];
            serviceLines = const [];
            installationsReady = false;
            tariffsReady = false;
            serviceLinesReady = false;

            if (nextHeader == null) {
              emit();
              return;
            }

            installationSubscription = database.installationDao
                .watchForObject(tenantId, nextHeader.object.id)
                .listen((rows) {
                  installations = rows
                      .map(mapInstallationRow)
                      .toList(growable: false);
                  installationsReady = true;
                  emit();
                }, onError: controller.addError);
            tariffSubscription = database.workOrderDao
                .watchObjectTariffs(tenantId, nextHeader.object.id)
                .listen((rows) {
                  availableTariffs = rows
                      .map(mapObjectTariffAssignmentRow)
                      .toList(growable: false);
                  tariffsReady = true;
                  emit();
                }, onError: controller.addError);
            serviceLineSubscription = database.workOrderDao
                .watchServiceLines(tenantId, nextHeader.workOrder.id)
                .listen((rows) {
                  serviceLines = rows
                      .map(mapWorkOrderServiceLineRow)
                      .toList(growable: false);
                  serviceLinesReady = true;
                  emit();
                }, onError: controller.addError);
          }, onError: controller.addError);
    };

    controller.onCancel = () async {
      await serviceLineSubscription?.cancel();
      await tariffSubscription?.cancel();
      await installationSubscription?.cancel();
      await headerSubscription.cancel();
    };

    return controller.stream;
  }

  @override
  Future<void> startWorkOrder(String id) async {
    await database.workOrderDao.startLocal(id: id, userId: userId);
  }

  @override
  Future<void> pauseWorkOrder(String id) async {
    await database.workOrderDao.pauseLocal(id);
  }

  @override
  Future<void> resumeWorkOrder(String id) async {
    await database.workOrderDao.resumeLocal(id: id, userId: userId);
  }

  @override
  Future<void> completeWorkOrder(String id, {String? notes}) async {
    await database.workOrderDao.completeLocal(id, notes: notes);
  }

  @override
  Future<void> addServiceLine(WorkOrderServiceLineDraft draft) {
    final errors = draft.validate();
    if (errors.isNotEmpty) {
      throw ArgumentError(errors.join(' '));
    }

    return database.workOrderDao.createServiceLineLocal(
      tenantId: tenantId,
      workOrderId: draft.workOrderId,
      objectTariffAssignmentId: draft.objectTariffAssignmentId,
      tariffCatalogItemId: draft.tariffCatalogItemId,
      installationId: draft.installationId,
      code: draft.code?.trim(),
      name: draft.name.trim(),
      quantity: draft.quantity,
      unit: draft.unit.trim(),
      unitPrice: draft.unitPrice,
      taxPoints: draft.taxPoints,
      notes: draft.notes?.trim(),
    );
  }

  @override
  Future<List<WorkOrder>> createDueRecurringWorkOrders(DateTime dueOn) async {
    final rows = await database.workOrderDao.createDueRecurringLocal(
      tenantId: tenantId,
      userId: userId,
      dueOn: dueOn,
    );
    return rows.map(mapWorkOrderRow).toList(growable: false);
  }
}

List<WorkOrder> _mapRows(List<WorkOrderRow> rows) {
  return rows.map(mapWorkOrderRow).toList(growable: false);
}
