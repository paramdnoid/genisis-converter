import '../entities/work_order.dart';
import '../entities/work_order_detail.dart';

abstract interface class WorkOrderRepository {
  Stream<List<WorkOrder>> watchAll();

  Stream<List<WorkOrder>> watchToday(DateTime day);

  Stream<WorkOrderDetail?> watchDetail(String id);

  Future<void> startWorkOrder(String id);

  Future<void> pauseWorkOrder(String id);

  Future<void> resumeWorkOrder(String id);

  Future<void> completeWorkOrder(String id, {String? notes});
}
