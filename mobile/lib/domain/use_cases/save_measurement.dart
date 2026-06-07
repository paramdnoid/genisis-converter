import '../entities/measurement.dart';
import '../repositories/measurement_repository.dart';
import 'validate_measurement.dart';

final class SaveMeasurement {
  const SaveMeasurement(
    this._repository, {
    this.validator = const ValidateMeasurement(),
  });

  final MeasurementRepository _repository;
  final ValidateMeasurement validator;

  Future<void> call(MeasurementDraft draft) async {
    validator(draft);
    await _repository.create(draft);
  }
}
