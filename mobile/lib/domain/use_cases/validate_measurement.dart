import '../../core/errors/app_error.dart';
import '../entities/measurement.dart';

final class ValidateMeasurement {
  const ValidateMeasurement();

  void call(MeasurementDraft draft) {
    final errors = <String>[];
    final rule = MeasurementRules.forType(draft.type);

    if (draft.workOrderId.trim().isEmpty) {
      errors.add('Auftrag fehlt.');
    }

    if (!rule.units.contains(draft.unit)) {
      errors.add('Einheit ist für diese Messart nicht erlaubt.');
    }

    if (!rule.accepts(draft.value)) {
      final min = rule.minValue;
      final max = rule.maxValue;
      if (min != null && max != null) {
        errors.add('Wert muss zwischen $min und $max ${draft.unit} liegen.');
      } else {
        errors.add('Wert ist nicht plausibel.');
      }
    }

    if (errors.isNotEmpty) {
      throw ValidationError(
        message: 'Messwert ist nicht plausibel.',
        metadata: {'missingItems': errors},
      );
    }
  }
}
