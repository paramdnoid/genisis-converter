import '../../core/errors/app_error.dart';
import '../entities/work_order_detail.dart';
import '../enums/work_order_status.dart';

final class CompletionValidationResult {
  const CompletionValidationResult({required this.missingItems});

  final List<String> missingItems;

  bool get canComplete => missingItems.isEmpty;
}

final class CompletionValidator {
  const CompletionValidator();

  CompletionValidationResult validate(WorkOrderDetail detail) {
    final missingItems = <String>[];
    final order = detail.workOrder;

    if (order.status != WorkOrderStatus.inProgress) {
      missingItems.add('Auftrag muss gestartet sein.');
    }

    if (order.actualStart == null) {
      missingItems.add('Startzeit fehlt.');
    }

    if (detail.installations.isEmpty) {
      missingItems.add('Mindestens eine Anlage muss verknuepft sein.');
    }

    return CompletionValidationResult(missingItems: missingItems);
  }

  void throwIfInvalid(WorkOrderDetail detail) {
    final result = validate(detail);
    if (result.canComplete) {
      return;
    }

    throw ValidationError(
      message: 'Auftrag kann noch nicht abgeschlossen werden.',
      metadata: {'missingItems': result.missingItems},
    );
  }
}
