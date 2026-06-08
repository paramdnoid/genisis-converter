import '../../domain/entities/report.dart';
import '../../domain/repositories/report_repository.dart';
import '../db/app_database.dart';

final class DriftReportRepository implements ReportRepository {
  const DriftReportRepository({required this.database, required this.tenantId});

  final AppDatabase database;
  final String tenantId;

  @override
  Stream<List<ReportRecord>> watchForWorkOrder(String workOrderId) {
    return database.reportDao
        .watchForWorkOrder(tenantId, workOrderId)
        .map((rows) => rows.map(_mapRow).toList(growable: false));
  }

  @override
  Future<String> createGenerated({
    required String workOrderId,
    required String reportNumber,
    required String pdfLocalPath,
    String? customerNameSigned,
    bool signed = false,
  }) {
    return database.reportDao.createGeneratedLocal(
      tenantId: tenantId,
      workOrderId: workOrderId,
      reportNumber: reportNumber,
      pdfLocalPath: pdfLocalPath,
      customerNameSigned: customerNameSigned,
      signed: signed,
    );
  }
}

ReportRecord _mapRow(ReportRow row) {
  return ReportRecord(
    id: row.id,
    tenantId: row.tenantId,
    workOrderId: row.workOrderId,
    reportNumber: row.reportNumber,
    status: row.status,
    pdfLocalPath: row.pdfLocalPath,
    pdfRemoteUrl: row.pdfRemoteUrl,
    generatedAt: row.generatedAt == null
        ? null
        : DateTime.tryParse(row.generatedAt!),
    signedAt: row.signedAt == null ? null : DateTime.tryParse(row.signedAt!),
    customerNameSigned: row.customerNameSigned,
    version: row.version,
    syncStatus: row.syncStatus,
  );
}
