import '../../domain/entities/measurement.dart';
import '../../domain/repositories/measurement_repository.dart';
import '../db/app_database.dart';

final class DriftMeasurementRepository implements MeasurementRepository {
  const DriftMeasurementRepository({
    required this.database,
    required this.tenantId,
  });

  final AppDatabase database;
  final String tenantId;

  @override
  Stream<List<Measurement>> watchForWorkOrder(String workOrderId) {
    return database.measurementDao
        .watchForWorkOrder(tenantId, workOrderId)
        .map((rows) => rows.map(_mapRow).toList(growable: false));
  }

  @override
  Future<void> create(MeasurementDraft draft) {
    return database.measurementDao.createLocal(
      tenantId: tenantId,
      workOrderId: draft.workOrderId,
      installationId: draft.installationId,
      measurementType: draft.type.value,
      value: draft.value,
      unit: draft.unit,
      deviceName: draft.deviceName,
      deviceSerial: draft.deviceSerial,
      notes: draft.notes,
    );
  }
}

Measurement _mapRow(MeasurementRow row) {
  return Measurement(
    id: row.id,
    tenantId: row.tenantId,
    workOrderId: row.workOrderId,
    installationId: row.installationId,
    type: MeasurementType.parse(row.measurementType),
    value: row.value,
    unit: row.unit,
    measuredAt: DateTime.parse(row.measuredAt),
    deviceName: row.deviceName,
    deviceSerial: row.deviceSerial,
    notes: row.notes,
    version: row.version,
    syncStatus: row.syncStatus,
  );
}
