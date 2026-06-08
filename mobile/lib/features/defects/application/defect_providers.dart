import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/db/database_providers.dart';
import '../../../data/repositories/drift_defect_repository.dart';
import '../../../domain/entities/defect.dart';
import '../../../domain/repositories/defect_repository.dart';
import '../../work_orders/application/work_order_providers.dart';

final defectRepositoryProvider = FutureProvider<DefectRepository>((ref) async {
  final database = await ref.watch(databaseReadyProvider.future);
  final tenantId = ref.watch(activeTenantIdProvider);
  return DriftDefectRepository(database: database, tenantId: tenantId);
});

final defectsForWorkOrderProvider = StreamProvider.autoDispose
    .family<List<Defect>, String>((ref, workOrderId) async* {
      final repository = await ref.watch(defectRepositoryProvider.future);
      yield* repository.watchForWorkOrder(workOrderId);
    });

final createDefectProvider = FutureProvider<CreateDefect>((ref) async {
  final repository = await ref.watch(defectRepositoryProvider.future);
  return CreateDefect(repository);
});

final resolveDefectProvider = FutureProvider<ResolveDefect>((ref) async {
  final repository = await ref.watch(defectRepositoryProvider.future);
  return ResolveDefect(repository);
});

final class CreateDefect {
  const CreateDefect(this._repository);

  final DefectRepository _repository;

  Future<void> call(DefectDraft draft) {
    return _repository.create(draft);
  }
}

final class ResolveDefect {
  const ResolveDefect(this._repository);

  final DefectRepository _repository;

  Future<void> call(String id) {
    return _repository.resolve(id);
  }
}
