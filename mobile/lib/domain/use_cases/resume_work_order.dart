import '../repositories/work_order_repository.dart';

final class ResumeWorkOrder {
  const ResumeWorkOrder(this._repository);

  final WorkOrderRepository _repository;

  Future<void> call(String workOrderId) {
    return _repository.resumeWorkOrder(workOrderId);
  }
}
