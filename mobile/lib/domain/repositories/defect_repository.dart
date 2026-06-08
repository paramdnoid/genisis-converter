import '../entities/defect.dart';

abstract interface class DefectRepository {
  Stream<List<Defect>> watchForWorkOrder(String workOrderId);
  Future<void> create(DefectDraft draft);
  Future<void> resolve(String id);
  Future<void> delete(String id);
}
