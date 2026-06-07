import '../repositories/work_order_repository.dart';
import 'completion_validator.dart';

final class CompleteWorkOrder {
  const CompleteWorkOrder(
    this._repository, {
    this.validator = const CompletionValidator(),
  });

  final WorkOrderRepository _repository;
  final CompletionValidator validator;

  Future<void> call(String workOrderId, {String? notes}) async {
    final detail = await _repository.watchDetail(workOrderId).first;
    if (detail == null) {
      return;
    }

    validator.throwIfInvalid(detail);
    await _repository.completeWorkOrder(workOrderId, notes: notes);
  }
}
