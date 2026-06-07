import '../repositories/checklist_repository.dart';

final class SaveChecklistAnswer {
  const SaveChecklistAnswer(this._repository);

  final ChecklistRepository _repository;

  Future<void> call({
    required String answerId,
    String? answerValue,
    String? comment,
    bool? isOk,
  }) {
    return _repository.saveAnswer(
      answerId: answerId,
      answerValue: answerValue,
      comment: comment,
      isOk: isOk,
    );
  }
}
