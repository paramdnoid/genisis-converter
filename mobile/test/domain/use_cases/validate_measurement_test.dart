import 'package:flutter_test/flutter_test.dart';
import 'package:kaminfeger_mobile/core/errors/app_error.dart';
import 'package:kaminfeger_mobile/domain/entities/measurement.dart';
import 'package:kaminfeger_mobile/domain/use_cases/validate_measurement.dart';

void main() {
  test('accepts values inside configured plausibility range', () {
    const validator = ValidateMeasurement();

    expect(
      () => validator(
        const MeasurementDraft(
          workOrderId: 'work-order-1',
          type: MeasurementType.co,
          value: 12,
          unit: 'ppm',
        ),
      ),
      returnsNormally,
    );
  });

  test('rejects values outside configured plausibility range', () {
    const validator = ValidateMeasurement();

    expect(
      () => validator(
        const MeasurementDraft(
          workOrderId: 'work-order-1',
          type: MeasurementType.o2,
          value: 40,
          unit: '%',
        ),
      ),
      throwsA(isA<ValidationError>()),
    );
  });
}
