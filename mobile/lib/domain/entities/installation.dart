final class Installation {
  const Installation({
    required this.id,
    required this.tenantId,
    required this.objectId,
    required this.type,
    this.manufacturer,
    this.model,
    this.serialNumber,
    this.fuelType,
    this.installationYear,
    this.locationDescription,
    this.intervalMonths,
    this.lastServiceDate,
    this.nextServiceDate,
    this.notes,
  });

  final String id;
  final String tenantId;
  final String objectId;
  final String type;
  final String? manufacturer;
  final String? model;
  final String? serialNumber;
  final String? fuelType;
  final int? installationYear;
  final String? locationDescription;
  final int? intervalMonths;
  final DateTime? lastServiceDate;
  final DateTime? nextServiceDate;
  final String? notes;

  String get displayName {
    final parts = [manufacturer, model]
        .where((part) => part != null && part.trim().isNotEmpty)
        .cast<String>()
        .join(' ');

    return parts.isEmpty ? type : parts;
  }
}
