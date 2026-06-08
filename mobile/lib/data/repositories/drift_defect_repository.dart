import '../../domain/entities/defect.dart';
import '../../domain/repositories/defect_repository.dart';
import '../db/app_database.dart';

final class DriftDefectRepository implements DefectRepository {
  const DriftDefectRepository({required this.database, required this.tenantId});

  final AppDatabase database;
  final String tenantId;

  @override
  Stream<List<Defect>> watchForWorkOrder(String workOrderId) {
    return database.defectDao
        .watchForWorkOrder(tenantId, workOrderId)
        .map((rows) => rows.map(_mapRow).toList(growable: false));
  }

  @override
  Future<void> create(DefectDraft draft) {
    final errors = draft.validate();
    if (errors.isNotEmpty) {
      throw ArgumentError(errors.join(' '));
    }

    return database.defectDao.createLocal(
      tenantId: tenantId,
      workOrderId: draft.workOrderId,
      installationId: draft.installationId,
      severity: draft.severity.value,
      title: draft.title.trim(),
      description: draft.description.trim(),
      recommendedAction: draft.recommendedAction?.trim(),
      dueDate: draft.dueDate?.toUtc().toIso8601String(),
    );
  }

  @override
  Future<void> resolve(String id) async {
    final row = await database.defectDao.getById(id);
    if (row == null) {
      return;
    }
    await database.defectDao.updateLocal(row.copyWith(resolved: true));
  }

  @override
  Future<void> delete(String id) {
    return database.defectDao.softDeleteLocal(id);
  }
}

Defect _mapRow(DefectRow row) {
  return Defect(
    id: row.id,
    tenantId: row.tenantId,
    workOrderId: row.workOrderId,
    installationId: row.installationId,
    severity: DefectSeverity.parse(row.severity),
    title: row.title,
    description: row.description,
    recommendedAction: row.recommendedAction,
    dueDate: row.dueDate == null ? null : DateTime.tryParse(row.dueDate!),
    resolved: row.resolved,
    version: row.version,
    syncStatus: row.syncStatus,
  );
}
