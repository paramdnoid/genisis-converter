import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/db/app_database.dart';
import '../../../data/db/database_providers.dart';
import '../../../data/repositories/drift_work_order_repository.dart';
import '../../../domain/entities/recurring_work_order_candidate.dart';
import '../../../domain/entities/work_order.dart';
import '../../../domain/entities/work_order_detail.dart';
import '../../../domain/entities/work_order_route_stop.dart';
import '../../../domain/repositories/work_order_repository.dart';
import '../../../domain/use_cases/add_work_order_service_line.dart';
import '../../../domain/use_cases/complete_work_order.dart';
import '../../../domain/use_cases/generate_recurring_work_orders.dart';
import '../../../domain/use_cases/pause_work_order.dart';
import '../../../domain/use_cases/resume_work_order.dart';
import '../../../domain/use_cases/start_work_order.dart';
import '../../auth/application/auth_providers.dart';

final activeTenantIdProvider = Provider<String>((ref) {
  return ref.watch(authSessionProvider).session?.tenantId ??
      DevelopmentSeed.tenantId;
});

final activeTechnicianUserIdProvider = Provider<String>((ref) {
  return ref.watch(authSessionProvider).session?.userId ??
      DevelopmentSeed.technicianUserId;
});

final workOrderRepositoryProvider = FutureProvider<WorkOrderRepository>((
  ref,
) async {
  final database = await ref.watch(databaseReadyProvider.future);
  final tenantId = ref.watch(activeTenantIdProvider);
  final userId = ref.watch(activeTechnicianUserIdProvider);
  return DriftWorkOrderRepository(
    database: database,
    tenantId: tenantId,
    userId: userId,
  );
});

final workOrdersProvider = StreamProvider.autoDispose<List<WorkOrder>>((
  ref,
) async* {
  final repository = await ref.watch(workOrderRepositoryProvider.future);
  yield* repository.watchAll();
});

final todayWorkOrdersProvider = StreamProvider.autoDispose<List<WorkOrder>>((
  ref,
) async* {
  final repository = await ref.watch(workOrderRepositoryProvider.future);
  yield* repository.watchToday(DateTime.now());
});

final todayRouteStopsProvider =
    StreamProvider.autoDispose<List<WorkOrderRouteStop>>((ref) async* {
      final repository = await ref.watch(workOrderRepositoryProvider.future);
      yield* repository.watchTodayRouteStops(DateTime.now());
    });

final dueRecurringWorkOrdersProvider =
    StreamProvider.autoDispose<List<RecurringWorkOrderCandidate>>((ref) async* {
      final repository = await ref.watch(workOrderRepositoryProvider.future);
      yield* repository.watchDueRecurringCandidates(DateTime.now());
    });

final workOrderDetailProvider = StreamProvider.autoDispose
    .family<WorkOrderDetail?, String>((ref, id) async* {
      final repository = await ref.watch(workOrderRepositoryProvider.future);
      yield* repository.watchDetail(id);
    });

final pendingOutboxCountProvider = StreamProvider.autoDispose<int>((
  ref,
) async* {
  final database = await ref.watch(databaseReadyProvider.future);
  final tenantId = ref.watch(activeTenantIdProvider);
  yield* database.outboxDao.watchPendingCount(tenantId);
});

final startWorkOrderProvider = FutureProvider<StartWorkOrder>((ref) async {
  final repository = await ref.watch(workOrderRepositoryProvider.future);
  return StartWorkOrder(repository);
});

final completeWorkOrderProvider = FutureProvider<CompleteWorkOrder>((
  ref,
) async {
  final repository = await ref.watch(workOrderRepositoryProvider.future);
  return CompleteWorkOrder(repository);
});

final pauseWorkOrderProvider = FutureProvider<PauseWorkOrder>((ref) async {
  final repository = await ref.watch(workOrderRepositoryProvider.future);
  return PauseWorkOrder(repository);
});

final resumeWorkOrderProvider = FutureProvider<ResumeWorkOrder>((ref) async {
  final repository = await ref.watch(workOrderRepositoryProvider.future);
  return ResumeWorkOrder(repository);
});

final addWorkOrderServiceLineProvider = FutureProvider<AddWorkOrderServiceLine>(
  (ref) async {
    final repository = await ref.watch(workOrderRepositoryProvider.future);
    return AddWorkOrderServiceLine(repository);
  },
);

final generateRecurringWorkOrdersProvider =
    FutureProvider<GenerateRecurringWorkOrders>((ref) async {
      final repository = await ref.watch(workOrderRepositoryProvider.future);
      return GenerateRecurringWorkOrders(repository);
    });
