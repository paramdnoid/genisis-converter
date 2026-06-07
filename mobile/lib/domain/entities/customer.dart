final class Customer {
  const Customer({
    required this.id,
    required this.tenantId,
    required this.type,
    required this.displayName,
    this.firstName,
    this.lastName,
    this.companyName,
    this.email,
    this.phone,
    this.mobile,
    this.billingAddress,
    this.notes,
  });

  final String id;
  final String tenantId;
  final String type;
  final String displayName;
  final String? firstName;
  final String? lastName;
  final String? companyName;
  final String? email;
  final String? phone;
  final String? mobile;
  final String? billingAddress;
  final String? notes;

  String? get preferredPhone => mobile ?? phone;
}
