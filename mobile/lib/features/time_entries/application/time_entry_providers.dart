import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/db/database_providers.dart';
import '../../../data/repositories/drift_time_entry_repository.dart';
import '../../../domain/entities/time_entry.dart';
import '../../../domain/repositories/time_entry_repository.dart';
import '../../work_orders/application/work_order_providers.dart';

final timeEntryRepositoryProvider = FutureProvider<TimeEntryRepository>((
  ref,
) async {
  final database = await ref.watch(databaseReadyProvider.future);
  final tenantId = ref.watch(activeTenantIdProvider);
  return DriftTimeEntryRepository(database: database, tenantId: tenantId);
});

final timeEntriesForWorkOrderProvider = StreamProvider.autoDispose
    .family<List<TimeEntry>, String>((ref, workOrderId) async* {
      final repository = await ref.watch(timeEntryRepositoryProvider.future);
      yield* repository.watchForWorkOrder(workOrderId);
    });

final createTimeEntryProvider = FutureProvider<CreateTimeEntry>((ref) async {
  final repository = await ref.watch(timeEntryRepositoryProvider.future);
  return CreateTimeEntry(repository);
});

final class CreateTimeEntry {
  const CreateTimeEntry(this._repository);

  final TimeEntryRepository _repository;

  Future<void> call(TimeEntryDraft draft) {
    return _repository.create(draft);
  }
}
