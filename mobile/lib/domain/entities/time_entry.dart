enum TimeEntryType {
  travel('travel', 'Reisezeit'),
  work('work', 'Arbeitszeit'),
  waiting('waiting', 'Wartezeit'),
  admin('admin', 'Administration');

  const TimeEntryType(this.value, this.label);

  final String value;
  final String label;

  static TimeEntryType parse(String value) {
    for (final type in TimeEntryType.values) {
      if (type.value == value) {
        return type;
      }
    }
    return TimeEntryType.work;
  }
}

final class TimeEntry {
  const TimeEntry({
    required this.id,
    required this.tenantId,
    required this.workOrderId,
    required this.userId,
    required this.type,
    required this.startTime,
    required this.version,
    required this.syncStatus,
    this.endTime,
    this.durationMinutes,
    this.notes,
  });

  final String id;
  final String tenantId;
  final String workOrderId;
  final String userId;
  final TimeEntryType type;
  final DateTime startTime;
  final DateTime? endTime;
  final int? durationMinutes;
  final String? notes;
  final int version;
  final String syncStatus;

  bool get isOpen => endTime == null;
  bool get isDirty => syncStatus != 'synced';
}

final class TimeEntryDraft {
  const TimeEntryDraft({
    required this.workOrderId,
    required this.userId,
    required this.type,
    required this.startTime,
    this.endTime,
    this.notes,
  });

  final String workOrderId;
  final String userId;
  final TimeEntryType type;
  final DateTime startTime;
  final DateTime? endTime;
  final String? notes;

  List<String> validate() {
    final end = endTime;
    if (end != null && end.isBefore(startTime)) {
      return const ['Endzeit darf nicht vor der Startzeit liegen.'];
    }
    return const [];
  }
}
