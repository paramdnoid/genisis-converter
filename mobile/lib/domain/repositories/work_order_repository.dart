import '../entities/recurring_work_order_candidate.dart';
import '../entities/work_order.dart';
import '../entities/work_order_detail.dart';
import '../entities/work_order_route_stop.dart';
import '../entities/work_order_service.dart';

abstract interface class WorkOrderRepository {
  Stream<List<WorkOrder>> watchAll();

  Stream<List<WorkOrder>> watchToday(DateTime day);

  Stream<List<WorkOrderRouteStop>> watchTodayRouteStops(DateTime day);

  Stream<List<RecurringWorkOrderCandidate>> watchDueRecurringCandidates(
    DateTime dueOn,
  );

  Stream<WorkOrderDetail?> watchDetail(String id);

  Future<void> startWorkOrder(String id);

  Future<void> pauseWorkOrder(String id);

  Future<void> resumeWorkOrder(String id);

  Future<void> completeWorkOrder(String id, {String? notes});

  Future<void> addServiceLine(WorkOrderServiceLineDraft draft);

  Future<List<WorkOrder>> createDueRecurringWorkOrders(DateTime dueOn);
}
