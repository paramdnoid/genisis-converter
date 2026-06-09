import '../entities/work_order_service.dart';
import '../repositories/work_order_repository.dart';

final class AddWorkOrderServiceLine {
  const AddWorkOrderServiceLine(this._repository);

  final WorkOrderRepository _repository;

  Future<void> call(WorkOrderServiceLineDraft draft) {
    return _repository.addServiceLine(draft);
  }
}
