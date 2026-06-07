enum MeasurementType {
  co('co', 'CO'),
  co2('co2', 'CO2'),
  o2('o2', 'O2'),
  temperature('temperature', 'Abgastemperatur'),
  draft('draft', 'Kaminzug'),
  soot('soot', 'Russzahl'),
  efficiency('efficiency', 'Wirkungsgrad'),
  pressure('pressure', 'Druck'),
  other('other', 'Sonstige');

  const MeasurementType(this.value, this.label);

  final String value;
  final String label;

  static MeasurementType parse(String value) {
    for (final type in MeasurementType.values) {
      if (type.value == value) {
        return type;
      }
    }

    return MeasurementType.other;
  }
}

final class Measurement {
  const Measurement({
    required this.id,
    required this.tenantId,
    required this.workOrderId,
    required this.type,
    required this.value,
    required this.unit,
    required this.measuredAt,
    required this.version,
    required this.syncStatus,
    this.installationId,
    this.deviceName,
    this.deviceSerial,
    this.notes,
  });

  final String id;
  final String tenantId;
  final String workOrderId;
  final MeasurementType type;
  final double value;
  final String unit;
  final DateTime measuredAt;
  final int version;
  final String syncStatus;
  final String? installationId;
  final String? deviceName;
  final String? deviceSerial;
  final String? notes;

  bool get isDirty => syncStatus != 'synced';
}

final class MeasurementDraft {
  const MeasurementDraft({
    required this.workOrderId,
    required this.type,
    required this.value,
    required this.unit,
    this.installationId,
    this.deviceName,
    this.deviceSerial,
    this.notes,
  });

  final String workOrderId;
  final MeasurementType type;
  final double value;
  final String unit;
  final String? installationId;
  final String? deviceName;
  final String? deviceSerial;
  final String? notes;
}

final class MeasurementRule {
  const MeasurementRule({
    required this.defaultUnit,
    required this.units,
    this.minValue,
    this.maxValue,
  });

  final String defaultUnit;
  final List<String> units;
  final double? minValue;
  final double? maxValue;

  bool accepts(double value) {
    final min = minValue;
    final max = maxValue;
    if (min != null && value < min) {
      return false;
    }
    if (max != null && value > max) {
      return false;
    }
    return true;
  }
}

abstract final class MeasurementRules {
  static const byType = <MeasurementType, MeasurementRule>{
    MeasurementType.co: MeasurementRule(
      defaultUnit: 'ppm',
      units: ['ppm', 'mg/m3'],
      minValue: 0,
      maxValue: 5000,
    ),
    MeasurementType.co2: MeasurementRule(
      defaultUnit: '%',
      units: ['%'],
      minValue: 0,
      maxValue: 20,
    ),
    MeasurementType.o2: MeasurementRule(
      defaultUnit: '%',
      units: ['%'],
      minValue: 0,
      maxValue: 25,
    ),
    MeasurementType.temperature: MeasurementRule(
      defaultUnit: '°C',
      units: ['°C'],
      minValue: -40,
      maxValue: 1200,
    ),
    MeasurementType.draft: MeasurementRule(
      defaultUnit: 'Pa',
      units: ['Pa', 'mbar'],
      minValue: -100,
      maxValue: 100,
    ),
    MeasurementType.soot: MeasurementRule(
      defaultUnit: 'index',
      units: ['index'],
      minValue: 0,
      maxValue: 9,
    ),
    MeasurementType.efficiency: MeasurementRule(
      defaultUnit: '%',
      units: ['%'],
      minValue: 0,
      maxValue: 120,
    ),
    MeasurementType.pressure: MeasurementRule(
      defaultUnit: 'mbar',
      units: ['mbar', 'Pa'],
      minValue: -500,
      maxValue: 500,
    ),
    MeasurementType.other: MeasurementRule(
      defaultUnit: 'Wert',
      units: ['Wert'],
    ),
  };

  static MeasurementRule forType(MeasurementType type) {
    return byType[type] ?? byType[MeasurementType.other]!;
  }
}
