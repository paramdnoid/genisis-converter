final class ObjectTariffAssignment {
  const ObjectTariffAssignment({
    required this.id,
    required this.tenantId,
    required this.tariffSystem,
    required this.description,
    required this.isActive,
    required this.version,
    required this.syncStatus,
    this.objectId,
    this.tariffCatalogItemId,
    this.code,
    this.position,
    this.defaultQuantity,
    this.unit,
    this.priceOverride,
    this.taxPoints,
    this.billingCode,
    this.intervalCode,
    this.notes,
  });

  final String id;
  final String tenantId;
  final String tariffSystem;
  final String description;
  final bool isActive;
  final int version;
  final String syncStatus;
  final String? objectId;
  final String? tariffCatalogItemId;
  final String? code;
  final int? position;
  final double? defaultQuantity;
  final String? unit;
  final double? priceOverride;
  final double? taxPoints;
  final String? billingCode;
  final String? intervalCode;
  final String? notes;

  String get displayCode => code?.trim().isEmpty ?? true ? '-' : code!.trim();
  String get displayUnit => unit?.trim().isEmpty ?? true ? 'Stk' : unit!.trim();
  double get suggestedQuantity =>
      defaultQuantity == null || defaultQuantity! <= 0 ? 1 : defaultQuantity!;
}

final class WorkOrderServiceLine {
  const WorkOrderServiceLine({
    required this.id,
    required this.tenantId,
    required this.workOrderId,
    required this.name,
    required this.quantity,
    required this.unit,
    required this.status,
    required this.version,
    required this.syncStatus,
    this.objectTariffAssignmentId,
    this.tariffCatalogItemId,
    this.installationId,
    this.code,
    this.unitPrice,
    this.totalPrice,
    this.taxPoints,
    this.notes,
  });

  final String id;
  final String tenantId;
  final String workOrderId;
  final String name;
  final double quantity;
  final String unit;
  final String status;
  final int version;
  final String syncStatus;
  final String? objectTariffAssignmentId;
  final String? tariffCatalogItemId;
  final String? installationId;
  final String? code;
  final double? unitPrice;
  final double? totalPrice;
  final double? taxPoints;
  final String? notes;

  bool get isDirty => syncStatus != 'synced';
}

final class WorkOrderServiceLineDraft {
  const WorkOrderServiceLineDraft({
    required this.workOrderId,
    required this.name,
    required this.quantity,
    required this.unit,
    this.objectTariffAssignmentId,
    this.tariffCatalogItemId,
    this.installationId,
    this.code,
    this.unitPrice,
    this.taxPoints,
    this.notes,
  });

  final String workOrderId;
  final String name;
  final double quantity;
  final String unit;
  final String? objectTariffAssignmentId;
  final String? tariffCatalogItemId;
  final String? installationId;
  final String? code;
  final double? unitPrice;
  final double? taxPoints;
  final String? notes;

  List<String> validate() {
    final missing = <String>[];
    if (workOrderId.trim().isEmpty) {
      missing.add('Auftrag fehlt.');
    }
    if (name.trim().isEmpty) {
      missing.add('Leistungsbezeichnung fehlt.');
    }
    if (quantity <= 0) {
      missing.add('Menge muss groesser als 0 sein.');
    }
    if (unit.trim().isEmpty) {
      missing.add('Einheit fehlt.');
    }
    return missing;
  }
}
