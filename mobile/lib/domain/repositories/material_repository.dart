import '../entities/material_usage.dart';

abstract interface class MaterialRepository {
  Stream<List<MaterialItem>> watchCatalog();
  Stream<List<WorkOrderMaterial>> watchForWorkOrder(String workOrderId);
  Future<void> createUsage(WorkOrderMaterialDraft draft);
}
