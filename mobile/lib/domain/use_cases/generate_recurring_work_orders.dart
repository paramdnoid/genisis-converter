import '../entities/work_order.dart';
import '../repositories/work_order_repository.dart';

final class GenerateRecurringWorkOrders {
  const GenerateRecurringWorkOrders(this.repository);

  final WorkOrderRepository repository;

  Future<List<WorkOrder>> call(DateTime dueOn) {
    return repository.createDueRecurringWorkOrders(dueOn);
  }
}
