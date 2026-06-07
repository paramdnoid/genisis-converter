import '../../core/errors/app_error.dart';
import '../entities/checklist.dart';

final class ValidateChecklist {
  const ValidateChecklist();

  ChecklistProgress call(List<ChecklistItemState> items) {
    return ChecklistProgress.fromItems(items);
  }

  void throwIfInvalid(List<ChecklistItemState> items) {
    final progress = call(items);
    if (progress.isValid) {
      return;
    }

    throw ValidationError(
      message: 'Pflichtfragen sind noch offen.',
      metadata: {'missingItems': progress.missingRequired},
    );
  }
}
