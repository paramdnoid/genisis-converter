import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/db/database_providers.dart';
import '../../../data/repositories/drift_material_repository.dart';
import '../../../domain/entities/material_usage.dart';
import '../../../domain/repositories/material_repository.dart';
import '../../work_orders/application/work_order_providers.dart';

final materialRepositoryProvider = FutureProvider<MaterialRepository>((
  ref,
) async {
  final database = await ref.watch(databaseReadyProvider.future);
  final tenantId = ref.watch(activeTenantIdProvider);
  return DriftMaterialRepository(database: database, tenantId: tenantId);
});

final materialCatalogProvider = StreamProvider.autoDispose<List<MaterialItem>>((
  ref,
) async* {
  final repository = await ref.watch(materialRepositoryProvider.future);
  yield* repository.watchCatalog();
});

final materialsForWorkOrderProvider = StreamProvider.autoDispose
    .family<List<WorkOrderMaterial>, String>((ref, workOrderId) async* {
      final repository = await ref.watch(materialRepositoryProvider.future);
      yield* repository.watchForWorkOrder(workOrderId);
    });

final createMaterialUsageProvider = FutureProvider<CreateMaterialUsage>((
  ref,
) async {
  final repository = await ref.watch(materialRepositoryProvider.future);
  return CreateMaterialUsage(repository);
});

final class CreateMaterialUsage {
  const CreateMaterialUsage(this._repository);

  final MaterialRepository _repository;

  Future<void> call(WorkOrderMaterialDraft draft) {
    return _repository.createUsage(draft);
  }
}
