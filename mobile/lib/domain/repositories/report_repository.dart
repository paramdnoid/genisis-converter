import '../entities/report.dart';

abstract interface class ReportRepository {
  Stream<List<ReportRecord>> watchForWorkOrder(String workOrderId);

  Future<String> createGenerated({
    required String workOrderId,
    required String reportNumber,
    required String pdfLocalPath,
    String? customerNameSigned,
    bool signed,
  });
}
