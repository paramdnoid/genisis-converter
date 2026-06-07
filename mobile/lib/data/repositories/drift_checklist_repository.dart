import 'dart:convert';

import '../../domain/entities/checklist.dart';
import '../../domain/enums/checklist_answer_type.dart';
import '../../domain/repositories/checklist_repository.dart';
import '../db/app_database.dart';

final class DriftChecklistRepository implements ChecklistRepository {
  const DriftChecklistRepository({
    required this.database,
    required this.tenantId,
  });

  final AppDatabase database;
  final String tenantId;

  @override
  Future<void> createFromTemplate({
    required String workOrderId,
    required String workOrderType,
  }) {
    return database.checklistDao.createAnswersFromTemplate(
      tenantId: tenantId,
      workOrderId: workOrderId,
      workOrderType: workOrderType,
    );
  }

  @override
  Stream<List<ChecklistItemState>> watchForWorkOrder({
    required String workOrderId,
    required String workOrderType,
  }) async* {
    final template = await database.checklistDao.getActiveTemplateForType(
      tenantId,
      workOrderType,
    );

    if (template == null) {
      yield const [];
      return;
    }

    final items = await database.checklistDao.getTemplateItems(
      tenantId,
      template.id,
    );

    yield* database.checklistDao
        .watchAnswersForWorkOrder(tenantId, workOrderId)
        .map((answers) {
          final answersByItemId = {
            for (final answer in answers) answer.templateItemId: answer,
          };

          return items
              .where((item) => answersByItemId.containsKey(item.id))
              .map(
                (item) => ChecklistItemState(
                  item: _mapItemRow(item),
                  answer: _mapAnswerRow(answersByItemId[item.id]!),
                ),
              )
              .toList(growable: false);
        });
  }

  @override
  Future<void> saveAnswer({
    required String answerId,
    String? answerValue,
    String? comment,
    bool? isOk,
  }) {
    return database.checklistDao.saveAnswerLocal(
      answerId: answerId,
      answerValue: answerValue,
      comment: comment,
      isOk: isOk,
    );
  }
}

ChecklistTemplateItem _mapItemRow(ChecklistTemplateItemRow row) {
  return ChecklistTemplateItem(
    id: row.id,
    tenantId: row.tenantId,
    templateId: row.templateId,
    position: row.position,
    label: row.label,
    helpText: row.helpText,
    answerType: ChecklistAnswerType.parse(row.answerType),
    required: row.required,
    options: _parseOptions(row.optionsJson),
  );
}

ChecklistAnswer _mapAnswerRow(ChecklistAnswerRow row) {
  return ChecklistAnswer(
    id: row.id,
    tenantId: row.tenantId,
    workOrderId: row.workOrderId,
    templateItemId: row.templateItemId,
    answerValue: row.answerValue,
    comment: row.comment,
    isOk: row.isOk,
    version: row.version,
    syncStatus: row.syncStatus,
  );
}

List<String> _parseOptions(String? value) {
  if (value == null || value.trim().isEmpty) {
    return const [];
  }

  final decoded = jsonDecode(value);
  if (decoded is! List) {
    return const [];
  }

  return decoded.map((option) => option.toString()).toList(growable: false);
}
