import '../../../data/db/app_database.dart';

final class ReportData {
  const ReportData({
    required this.header,
    required this.installations,
    required this.measurements,
    required this.defects,
    required this.photos,
    required this.timeEntries,
    required this.materials,
  });

  final WorkOrderDetailHeaderRow header;
  final List<InstallationRow> installations;
  final List<MeasurementRow> measurements;
  final List<DefectRow> defects;
  final List<PhotoRow> photos;
  final List<TimeEntryRow> timeEntries;
  final List<WorkOrderMaterialRow> materials;
}

final class ReportDataAggregator {
  const ReportDataAggregator({required this.database, required this.tenantId});

  final AppDatabase database;
  final String tenantId;

  Future<ReportData?> load(String workOrderId) async {
    final header = await database.workOrderDao
        .watchDetailHeader(tenantId, workOrderId)
        .first;
    if (header == null) {
      return null;
    }

    final installations = await database.installationDao
        .watchForObject(tenantId, header.object.id)
        .first;
    final measurements = await database.measurementDao
        .watchForWorkOrder(tenantId, workOrderId)
        .first;
    final defects = await database.defectDao
        .watchForWorkOrder(tenantId, workOrderId)
        .first;
    final photos = await database.photoDao
        .watchForWorkOrder(tenantId, workOrderId)
        .first;
    final timeEntries = await database.timeEntryDao
        .watchForWorkOrder(tenantId, workOrderId)
        .first;
    final materials = await database.materialDao
        .watchForWorkOrder(tenantId, workOrderId)
        .first;

    return ReportData(
      header: header,
      installations: installations,
      measurements: measurements,
      defects: defects,
      photos: photos,
      timeEntries: timeEntries,
      materials: materials,
    );
  }
}
