import 'dart:async';

import '../../domain/entities/installation.dart';
import '../../domain/entities/work_order.dart';
import '../../domain/entities/work_order_detail.dart';
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
  Stream<WorkOrderDetail?> watchDetail(String id) {
    late StreamSubscription<WorkOrderDetailHeaderRow?> headerSubscription;
    StreamSubscription<List<InstallationRow>>? installationSubscription;

    final controller = StreamController<WorkOrderDetail?>();
    WorkOrderDetailHeaderRow? header;
    List<Installation> installations = const [];

    void emit() {
      final currentHeader = header;
      if (currentHeader == null) {
        controller.add(null);
        return;
      }

      controller.add(
        WorkOrderDetail(
          workOrder: mapWorkOrderRow(currentHeader.workOrder),
          customer: mapCustomerRow(currentHeader.customer),
          object: mapCustomerObjectRow(currentHeader.object),
          installations: installations,
        ),
      );
    }

    controller.onListen = () {
      headerSubscription = database.workOrderDao
          .watchDetailHeader(tenantId, id)
          .listen((nextHeader) {
            header = nextHeader;
            installationSubscription?.cancel();
            installations = const [];

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
                  emit();
                }, onError: controller.addError);
          }, onError: controller.addError);
    };

    controller.onCancel = () async {
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
}

List<WorkOrder> _mapRows(List<WorkOrderRow> rows) {
  return rows.map(mapWorkOrderRow).toList(growable: false);
}
