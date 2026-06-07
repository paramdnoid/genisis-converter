import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/db/app_database.dart';
import '../../../data/db/database_providers.dart';
import '../../../data/repositories/drift_work_order_repository.dart';
import '../../../domain/entities/work_order.dart';
import '../../../domain/entities/work_order_detail.dart';
import '../../../domain/repositories/work_order_repository.dart';
import '../../../domain/use_cases/complete_work_order.dart';
import '../../../domain/use_cases/pause_work_order.dart';
import '../../../domain/use_cases/resume_work_order.dart';
import '../../../domain/use_cases/start_work_order.dart';

final activeTenantIdProvider = Provider<String>((ref) {
  return DevelopmentSeed.tenantId;
});

final activeTechnicianUserIdProvider = Provider<String>((ref) {
  return DevelopmentSeed.technicianUserId;
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
