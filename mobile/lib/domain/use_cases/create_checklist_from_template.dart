import '../repositories/checklist_repository.dart';

final class CreateChecklistFromTemplate {
  const CreateChecklistFromTemplate(this._repository);

  final ChecklistRepository _repository;

  Future<void> call({
    required String workOrderId,
    required String workOrderType,
  }) {
    return _repository.createFromTemplate(
      workOrderId: workOrderId,
      workOrderType: workOrderType,
    );
  }
}
