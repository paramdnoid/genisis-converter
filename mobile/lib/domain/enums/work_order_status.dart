enum WorkOrderStatus {
  draft('draft', 'Entwurf'),
  scheduled('scheduled', 'Geplant'),
  inProgress('in_progress', 'In Arbeit'),
  paused('paused', 'Pausiert'),
  completed('completed', 'Abgeschlossen'),
  synced('synced', 'Synchronisiert'),
  cancelled('cancelled', 'Storniert'),
  unknown('unknown', 'Unbekannt');

  const WorkOrderStatus(this.value, this.label);

  final String value;
  final String label;

  bool get canStart => this == WorkOrderStatus.scheduled;
  bool get canPause => this == WorkOrderStatus.inProgress;
  bool get canResume => this == WorkOrderStatus.paused;
  bool get canComplete => this == WorkOrderStatus.inProgress;

  static WorkOrderStatus parse(String value) {
    for (final status in WorkOrderStatus.values) {
      if (status.value == value) {
        return status;
      }
    }

    return WorkOrderStatus.unknown;
  }
}

enum WorkOrderPriority {
  low('low', 'Tief'),
  normal('normal', 'Normal'),
  high('high', 'Hoch'),
  urgent('urgent', 'Dringend'),
  unknown('unknown', 'Unbekannt');

  const WorkOrderPriority(this.value, this.label);

  final String value;
  final String label;

  static WorkOrderPriority parse(String value) {
    for (final priority in WorkOrderPriority.values) {
      if (priority.value == value) {
        return priority;
      }
    }

    return WorkOrderPriority.unknown;
  }
}
