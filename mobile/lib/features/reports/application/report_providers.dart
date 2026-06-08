import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/db/database_providers.dart';
import '../../../data/repositories/drift_report_repository.dart';
import '../../../domain/entities/report.dart';
import '../../../domain/repositories/report_repository.dart';
import '../../work_orders/application/work_order_providers.dart';

final reportRepositoryProvider = FutureProvider<ReportRepository>((ref) async {
  final database = await ref.watch(databaseReadyProvider.future);
  final tenantId = ref.watch(activeTenantIdProvider);
  return DriftReportRepository(database: database, tenantId: tenantId);
});

final reportsForWorkOrderProvider = StreamProvider.autoDispose
    .family<List<ReportRecord>, String>((ref, workOrderId) async* {
      final repository = await ref.watch(reportRepositoryProvider.future);
      yield* repository.watchForWorkOrder(workOrderId);
    });

final createReportRecordProvider = FutureProvider<CreateReportRecord>((
  ref,
) async {
  final repository = await ref.watch(reportRepositoryProvider.future);
  return CreateReportRecord(repository);
});

final class CreateReportRecord {
  const CreateReportRecord(this._repository);

  final ReportRepository _repository;

  Future<String> call({
    required String workOrderId,
    required String reportNumber,
    required String pdfLocalPath,
    String? customerNameSigned,
    bool signed = false,
  }) {
    return _repository.createGenerated(
      workOrderId: workOrderId,
      reportNumber: reportNumber,
      pdfLocalPath: pdfLocalPath,
      customerNameSigned: customerNameSigned,
      signed: signed,
    );
  }
}
