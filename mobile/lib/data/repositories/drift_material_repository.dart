import '../../domain/entities/material_usage.dart';
import '../../domain/repositories/material_repository.dart';
import '../db/app_database.dart';

final class DriftMaterialRepository implements MaterialRepository {
  const DriftMaterialRepository({
    required this.database,
    required this.tenantId,
  });

  final AppDatabase database;
  final String tenantId;

  @override
  Stream<List<MaterialItem>> watchCatalog() {
    return database.materialDao
        .watchActiveMaterials(tenantId)
        .map((rows) => rows.map(_mapCatalogRow).toList(growable: false));
  }

  @override
  Stream<List<WorkOrderMaterial>> watchForWorkOrder(String workOrderId) {
    return database.materialDao
        .watchForWorkOrder(tenantId, workOrderId)
        .map((rows) => rows.map(_mapUsageRow).toList(growable: false));
  }

  @override
  Future<void> createUsage(WorkOrderMaterialDraft draft) {
    final errors = draft.validate();
    if (errors.isNotEmpty) {
      throw ArgumentError(errors.join(' '));
    }

    return database.materialDao.createWorkOrderMaterialLocal(
      tenantId: tenantId,
      workOrderId: draft.workOrderId,
      materialId: draft.materialId,
      name: draft.name.trim(),
      quantity: draft.quantity,
      unit: draft.unit.trim(),
      notes: draft.notes?.trim(),
    );
  }
}

MaterialItem _mapCatalogRow(MaterialRow row) {
  return MaterialItem(
    id: row.id,
    tenantId: row.tenantId,
    sku: row.sku,
    name: row.name,
    unit: row.unit,
    defaultPrice: row.defaultPrice,
    isActive: row.isActive,
  );
}

WorkOrderMaterial _mapUsageRow(WorkOrderMaterialRow row) {
  return WorkOrderMaterial(
    id: row.id,
    tenantId: row.tenantId,
    workOrderId: row.workOrderId,
    materialId: row.materialId,
    name: row.name,
    quantity: row.quantity,
    unit: row.unit,
    notes: row.notes,
    version: row.version,
    syncStatus: row.syncStatus,
  );
}
