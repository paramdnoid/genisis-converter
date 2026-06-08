import '../entities/time_entry.dart';

abstract interface class TimeEntryRepository {
  Stream<List<TimeEntry>> watchForWorkOrder(String workOrderId);
  Future<void> create(TimeEntryDraft draft);
}
