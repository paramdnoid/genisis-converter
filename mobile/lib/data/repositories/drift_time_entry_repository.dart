import '../../domain/entities/time_entry.dart';
import '../../domain/repositories/time_entry_repository.dart';
import '../db/app_database.dart';

final class DriftTimeEntryRepository implements TimeEntryRepository {
  const DriftTimeEntryRepository({
    required this.database,
    required this.tenantId,
  });

  final AppDatabase database;
  final String tenantId;

  @override
  Stream<List<TimeEntry>> watchForWorkOrder(String workOrderId) {
    return database.timeEntryDao
        .watchForWorkOrder(tenantId, workOrderId)
        .map((rows) => rows.map(_mapRow).toList(growable: false));
  }

  @override
  Future<void> create(TimeEntryDraft draft) {
    final errors = draft.validate();
    if (errors.isNotEmpty) {
      throw ArgumentError(errors.join(' '));
    }

    return database.timeEntryDao.createLocal(
      tenantId: tenantId,
      workOrderId: draft.workOrderId,
      userId: draft.userId,
      type: draft.type.value,
      startTime: draft.startTime.toUtc().toIso8601String(),
      endTime: draft.endTime?.toUtc().toIso8601String(),
      notes: draft.notes,
    );
  }
}

TimeEntry _mapRow(TimeEntryRow row) {
  return TimeEntry(
    id: row.id,
    tenantId: row.tenantId,
    workOrderId: row.workOrderId,
    userId: row.userId,
    type: TimeEntryType.parse(row.type),
    startTime: DateTime.parse(row.startTime),
    endTime: row.endTime == null ? null : DateTime.tryParse(row.endTime!),
    durationMinutes: row.durationMinutes,
    notes: row.notes,
    version: row.version,
    syncStatus: row.syncStatus,
  );
}
