import '../repositories/work_order_repository.dart';

final class StartWorkOrder {
  const StartWorkOrder(this._repository);

  final WorkOrderRepository _repository;

  Future<void> call(String workOrderId) {
    return _repository.startWorkOrder(workOrderId);
  }
}
