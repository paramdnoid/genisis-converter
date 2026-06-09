import 'dart:typed_data';

import 'package:drift/native.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kaminfeger_mobile/data/db/app_database.dart';
import 'package:kaminfeger_mobile/features/reports/application/report_data_aggregator.dart';
import 'package:kaminfeger_mobile/features/reports/application/report_share_service.dart';

void main() {
  late AppDatabase database;

  setUp(() async {
    database = AppDatabase.forTesting(NativeDatabase.memory());
    await database.seedDevelopmentData();
  });

  tearDown(() async {
    await database.close();
  });

  test('shares generated report PDF with email metadata', () async {
    final data = await ReportDataAggregator(
      database: database,
      tenantId: DevelopmentSeed.tenantId,
    ).load(DevelopmentSeed.workOrderInspectionId);
    final captured = _CapturedShare();
    final service = ReportShareService(sharePdf: captured.call);

    final shared = await service.shareByEmail(
      data: data!,
      subject: 'Rapport WO-2026-0001 - Familie Keller',
      body: 'Rapport im Anhang.',
    );

    expect(shared, isTrue);
    expect(captured.bytes, isNotNull);
    expect(String.fromCharCodes(captured.bytes!.take(5)), '%PDF-');
    expect(captured.filename, 'rapport-WO-2026-0001.pdf');
    expect(captured.subject, 'Rapport WO-2026-0001 - Familie Keller');
    expect(captured.body, 'Rapport im Anhang.');
    expect(captured.emails, ['nora.keller@example.ch']);
  });
}

final class _CapturedShare {
  Uint8List? bytes;
  String? filename;
  Rect? bounds;
  String? subject;
  String? body;
  List<String>? emails;

  Future<bool> call({
    required Uint8List bytes,
    String filename = 'document.pdf',
    Rect? bounds,
    String? subject,
    String? body,
    List<String>? emails,
  }) async {
    this.bytes = bytes;
    this.filename = filename;
    this.bounds = bounds;
    this.subject = subject;
    this.body = body;
    this.emails = emails;
    return true;
  }
}
