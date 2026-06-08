final class MaterialItem {
  const MaterialItem({
    required this.id,
    required this.tenantId,
    required this.name,
    required this.unit,
    required this.isActive,
    this.sku,
    this.defaultPrice,
  });

  final String id;
  final String tenantId;
  final String name;
  final String unit;
  final bool isActive;
  final String? sku;
  final double? defaultPrice;
}

final class WorkOrderMaterial {
  const WorkOrderMaterial({
    required this.id,
    required this.tenantId,
    required this.workOrderId,
    required this.name,
    required this.quantity,
    required this.unit,
    required this.version,
    required this.syncStatus,
    this.materialId,
    this.notes,
  });

  final String id;
  final String tenantId;
  final String workOrderId;
  final String name;
  final double quantity;
  final String unit;
  final int version;
  final String syncStatus;
  final String? materialId;
  final String? notes;

  bool get isDirty => syncStatus != 'synced';
}

final class WorkOrderMaterialDraft {
  const WorkOrderMaterialDraft({
    required this.workOrderId,
    required this.name,
    required this.quantity,
    required this.unit,
    this.materialId,
    this.notes,
  });

  final String workOrderId;
  final String name;
  final double quantity;
  final String unit;
  final String? materialId;
  final String? notes;

  List<String> validate() {
    final missing = <String>[];
    if (name.trim().isEmpty) {
      missing.add('Materialbezeichnung fehlt.');
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
