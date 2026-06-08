final class ReportRecord {
  const ReportRecord({
    required this.id,
    required this.tenantId,
    required this.workOrderId,
    required this.reportNumber,
    required this.status,
    required this.version,
    required this.syncStatus,
    this.pdfLocalPath,
    this.pdfRemoteUrl,
    this.generatedAt,
    this.signedAt,
    this.customerNameSigned,
  });

  final String id;
  final String tenantId;
  final String workOrderId;
  final String reportNumber;
  final String status;
  final int version;
  final String syncStatus;
  final String? pdfLocalPath;
  final String? pdfRemoteUrl;
  final DateTime? generatedAt;
  final DateTime? signedAt;
  final String? customerNameSigned;

  bool get isSigned => signedAt != null || status == 'signed';
  bool get isDirty => syncStatus != 'synced';
}
