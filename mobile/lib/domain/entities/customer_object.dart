final class CustomerObject {
  const CustomerObject({
    required this.id,
    required this.tenantId,
    required this.customerId,
    required this.name,
    required this.street,
    required this.houseNumber,
    required this.postalCode,
    required this.city,
    required this.country,
    this.latitude,
    this.longitude,
    this.accessNotes,
    this.safetyNotes,
    this.objectNotes,
  });

  final String id;
  final String tenantId;
  final String customerId;
  final String name;
  final String street;
  final String houseNumber;
  final String postalCode;
  final String city;
  final String country;
  final double? latitude;
  final double? longitude;
  final String? accessNotes;
  final String? safetyNotes;
  final String? objectNotes;

  String get addressLine => '$street $houseNumber, $postalCode $city';
}
