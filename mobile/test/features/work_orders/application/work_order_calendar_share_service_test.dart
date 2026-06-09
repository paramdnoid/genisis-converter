import 'dart:convert';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kaminfeger_mobile/data/db/app_database.dart';
import 'package:kaminfeger_mobile/data/repositories/drift_work_order_repository.dart';
import 'package:kaminfeger_mobile/domain/entities/work_order.dart';
import 'package:kaminfeger_mobile/domain/entities/work_order_detail.dart';
import 'package:kaminfeger_mobile/features/work_orders/application/work_order_calendar_share_service.dart';
import 'package:share_plus/share_plus.dart';

void main() {
  late AppDatabase database;
  late DriftWorkOrderRepository repository;

  setUp(() async {
    database = AppDatabase.forTesting(NativeDatabase.memory());
    await database.seedDevelopmentData();
    repository = DriftWorkOrderRepository(
      database: database,
      tenantId: DevelopmentSeed.tenantId,
      userId: DevelopmentSeed.technicianUserId,
    );
  });

  tearDown(() async {
    await database.close();
  });

  test('shares scheduled work order as calendar ICS file', () async {
    final detail = await _loadInspectionDetail(repository);
    final captured = _CapturedCalendarShare();
    final service = WorkOrderCalendarShareService(
      share: captured.call,
      now: () => DateTime.utc(2026, 1, 2, 3, 4, 5),
    );

    final result = await service.share(detail);

    expect(result.status, ShareResultStatus.success);
    expect(captured.params, isNotNull);
    expect(captured.params!.fileNameOverrides, ['termin-WO-2026-0001.ics']);
    expect(captured.params!.title, 'Jahreskontrolle Cheminée');
    expect(captured.params!.subject, 'Jahreskontrolle Cheminée');

    final files = captured.params!.files;
    expect(files, hasLength(1));
    expect(files!.single.mimeType, 'text/calendar');

    final ics = utf8.decode(await files.single.readAsBytes());
    final unfolded = ics.replaceAll('\r\n ', '');
    expect(unfolded, contains('BEGIN:VCALENDAR\r\nVERSION:2.0'));
    expect(unfolded, contains('BEGIN:VEVENT'));
    expect(unfolded, contains('DTSTAMP:20260102T030405Z'));
    expect(
      unfolded,
      contains('DTSTART:${_formatUtc(detail.workOrder.scheduledStart!)}'),
    );
    expect(
      unfolded,
      contains('DTEND:${_formatUtc(detail.workOrder.scheduledEnd!)}'),
    );
    expect(
      unfolded,
      contains('SUMMARY:WO-2026-0001 - Jahreskontrolle Cheminée'),
    );
    expect(unfolded, contains('LOCATION:Im Ried 7\\, 8610 Uster'));
    expect(
      unfolded,
      contains(
        'DESCRIPTION:Auftrag: WO-2026-0001\\n'
        'Kunde: Familie Keller\\n'
        'Objekt: Einfamilienhaus Keller\\n'
        'Adresse: Im Ried 7\\, 8610 Uster\\n',
      ),
    );
    expect(unfolded, endsWith('END:VCALENDAR\r\n'));
  });

  test('rejects unscheduled work order calendar export', () async {
    final detail = await _loadInspectionDetail(repository);
    final service = WorkOrderCalendarShareService(
      now: () => DateTime.utc(2026, 1, 2, 3, 4, 5),
    );
    final unscheduled = WorkOrderDetail(
      workOrder: _copyWorkOrder(detail.workOrder, scheduledStart: null),
      customer: detail.customer,
      object: detail.object,
      installations: detail.installations,
      availableTariffs: detail.availableTariffs,
      serviceLines: detail.serviceLines,
    );

    expect(() => service.buildIcs(unscheduled), throwsStateError);
  });
}

Future<WorkOrderDetail> _loadInspectionDetail(
  DriftWorkOrderRepository repository,
) async {
  final detail = await repository
      .watchDetail(DevelopmentSeed.workOrderInspectionId)
      .firstWhere((detail) => detail != null);
  return detail!;
}

String _formatUtc(DateTime value) {
  final utc = value.toUtc();
  String two(int number) => number.toString().padLeft(2, '0');
  return '${utc.year}${two(utc.month)}${two(utc.day)}T'
      '${two(utc.hour)}${two(utc.minute)}${two(utc.second)}Z';
}

final class _CapturedCalendarShare {
  ShareParams? params;

  Future<ShareResult> call(ShareParams params) async {
    this.params = params;
    return const ShareResult('calendar', ShareResultStatus.success);
  }
}

WorkOrder _copyWorkOrder(WorkOrder source, {DateTime? scheduledStart}) {
  return WorkOrder(
    id: source.id,
    tenantId: source.tenantId,
    orderNumber: source.orderNumber,
    title: source.title,
    type: source.type,
    status: source.status,
    priority: source.priority,
    version: source.version,
    syncStatus: source.syncStatus,
    description: source.description,
    customerId: source.customerId,
    objectId: source.objectId,
    assignedUserId: source.assignedUserId,
    scheduledStart: scheduledStart,
    scheduledEnd: source.scheduledEnd,
    actualStart: source.actualStart,
    actualEnd: source.actualEnd,
    completionNotes: source.completionNotes,
  );
}
