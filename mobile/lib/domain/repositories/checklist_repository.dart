import '../entities/checklist.dart';

abstract interface class ChecklistRepository {
  Future<void> createFromTemplate({
    required String workOrderId,
    required String workOrderType,
  });

  Stream<List<ChecklistItemState>> watchForWorkOrder({
    required String workOrderId,
    required String workOrderType,
  });

  Future<void> saveAnswer({
    required String answerId,
    String? answerValue,
    String? comment,
    bool? isOk,
  });
}
