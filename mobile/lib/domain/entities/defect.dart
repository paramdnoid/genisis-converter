enum DefectSeverity {
  info('info', 'Info'),
  minor('minor', 'Gering'),
  major('major', 'Erheblich'),
  critical('critical', 'Kritisch');

  const DefectSeverity(this.value, this.label);

  final String value;
  final String label;

  static DefectSeverity parse(String value) {
    for (final severity in DefectSeverity.values) {
      if (severity.value == value) {
        return severity;
      }
    }
    return DefectSeverity.info;
  }
}

final class Defect {
  const Defect({
    required this.id,
    required this.tenantId,
    required this.workOrderId,
    required this.severity,
    required this.title,
    required this.description,
    required this.resolved,
    required this.version,
    required this.syncStatus,
    this.installationId,
    this.recommendedAction,
    this.dueDate,
  });

  final String id;
  final String tenantId;
  final String workOrderId;
  final DefectSeverity severity;
  final String title;
  final String description;
  final bool resolved;
  final int version;
  final String syncStatus;
  final String? installationId;
  final String? recommendedAction;
  final DateTime? dueDate;

  bool get isCritical => severity == DefectSeverity.critical;
  bool get isDirty => syncStatus != 'synced';
}

final class DefectDraft {
  const DefectDraft({
    required this.workOrderId,
    required this.severity,
    required this.title,
    required this.description,
    this.installationId,
    this.recommendedAction,
    this.dueDate,
  });

  final String workOrderId;
  final DefectSeverity severity;
  final String title;
  final String description;
  final String? installationId;
  final String? recommendedAction;
  final DateTime? dueDate;

  List<String> validate() {
    final missing = <String>[];
    if (title.trim().isEmpty) {
      missing.add('Titel fehlt.');
    }
    if (description.trim().isEmpty) {
      missing.add('Beschreibung fehlt.');
    }
    if (severity == DefectSeverity.critical && recommendedAction == null) {
      missing.add('Empfohlene Massnahme fuer kritischen Mangel fehlt.');
    }
    return missing;
  }
}
