import '../entities/measurement.dart';

abstract interface class MeasurementRepository {
  Stream<List<Measurement>> watchForWorkOrder(String workOrderId);

  Future<void> create(MeasurementDraft draft);
}
