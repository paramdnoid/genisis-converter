import '../repositories/work_order_repository.dart';

final class PauseWorkOrder {
  const PauseWorkOrder(this._repository);

  final WorkOrderRepository _repository;

  Future<void> call(String workOrderId) {
    return _repository.pauseWorkOrder(workOrderId);
  }
}
