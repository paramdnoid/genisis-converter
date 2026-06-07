import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/db/database_providers.dart';
import '../../../data/repositories/drift_checklist_repository.dart';
import '../../../domain/entities/checklist.dart';
import '../../../domain/repositories/checklist_repository.dart';
import '../../../domain/use_cases/create_checklist_from_template.dart';
import '../../../domain/use_cases/save_checklist_answer.dart';
import '../../../domain/use_cases/validate_checklist.dart';
import '../../work_orders/application/work_order_providers.dart';

typedef ChecklistRequest = ({String workOrderId, String workOrderType});

final checklistRepositoryProvider = FutureProvider<ChecklistRepository>((
  ref,
) async {
  final database = await ref.watch(databaseReadyProvider.future);
  final tenantId = ref.watch(activeTenantIdProvider);
  return DriftChecklistRepository(database: database, tenantId: tenantId);
});

final createChecklistFromTemplateProvider =
    FutureProvider<CreateChecklistFromTemplate>((ref) async {
      final repository = await ref.watch(checklistRepositoryProvider.future);
      return CreateChecklistFromTemplate(repository);
    });

final saveChecklistAnswerProvider = FutureProvider<SaveChecklistAnswer>((
  ref,
) async {
  final repository = await ref.watch(checklistRepositoryProvider.future);
  return SaveChecklistAnswer(repository);
});

final validateChecklistProvider = Provider<ValidateChecklist>((ref) {
  return const ValidateChecklist();
});

final ensureChecklistProvider = FutureProvider.autoDispose
    .family<void, ChecklistRequest>((ref, request) async {
      final useCase = await ref.watch(
        createChecklistFromTemplateProvider.future,
      );
      await useCase(
        workOrderId: request.workOrderId,
        workOrderType: request.workOrderType,
      );
    });

final checklistItemsProvider = StreamProvider.autoDispose
    .family<List<ChecklistItemState>, ChecklistRequest>((ref, request) async* {
      await ref.watch(ensureChecklistProvider(request).future);
      final repository = await ref.watch(checklistRepositoryProvider.future);
      yield* repository.watchForWorkOrder(
        workOrderId: request.workOrderId,
        workOrderType: request.workOrderType,
      );
    });

final checklistProgressProvider = Provider.autoDispose
    .family<ChecklistProgress, List<ChecklistItemState>>((ref, items) {
      return ChecklistProgress.fromItems(items);
    });
