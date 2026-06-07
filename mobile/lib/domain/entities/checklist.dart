import '../enums/checklist_answer_type.dart';

final class ChecklistTemplate {
  const ChecklistTemplate({
    required this.id,
    required this.tenantId,
    required this.name,
    required this.type,
    required this.versionNumber,
    required this.isActive,
  });

  final String id;
  final String tenantId;
  final String name;
  final String type;
  final int versionNumber;
  final bool isActive;
}

final class ChecklistTemplateItem {
  const ChecklistTemplateItem({
    required this.id,
    required this.tenantId,
    required this.templateId,
    required this.position,
    required this.label,
    required this.answerType,
    required this.required,
    required this.options,
    this.helpText,
  });

  final String id;
  final String tenantId;
  final String templateId;
  final int position;
  final String label;
  final ChecklistAnswerType answerType;
  final bool required;
  final List<String> options;
  final String? helpText;
}

final class ChecklistAnswer {
  const ChecklistAnswer({
    required this.id,
    required this.tenantId,
    required this.workOrderId,
    required this.templateItemId,
    required this.version,
    required this.syncStatus,
    this.answerValue,
    this.comment,
    this.isOk,
  });

  final String id;
  final String tenantId;
  final String workOrderId;
  final String templateItemId;
  final String? answerValue;
  final String? comment;
  final bool? isOk;
  final int version;
  final String syncStatus;

  bool get isDirty => syncStatus != 'synced';
}

final class ChecklistItemState {
  const ChecklistItemState({required this.item, required this.answer});

  final ChecklistTemplateItem item;
  final ChecklistAnswer answer;

  bool get isAnswered {
    final value = answer.answerValue?.trim();
    if (value == null || value.isEmpty) {
      return false;
    }

    return switch (item.answerType) {
      ChecklistAnswerType.multiSelect => value != '[]',
      _ => true,
    };
  }

  bool get isMissingRequired => item.required && !isAnswered;
}

final class ChecklistProgress {
  const ChecklistProgress({
    required this.completed,
    required this.total,
    required this.missingRequired,
  });

  factory ChecklistProgress.fromItems(List<ChecklistItemState> items) {
    return ChecklistProgress(
      completed: items.where((item) => item.isAnswered).length,
      total: items.length,
      missingRequired: items
          .where((item) => item.isMissingRequired)
          .map((item) => item.item.label)
          .toList(growable: false),
    );
  }

  final int completed;
  final int total;
  final List<String> missingRequired;

  double get ratio => total == 0 ? 0 : completed / total;
  bool get isValid => missingRequired.isEmpty;
}
