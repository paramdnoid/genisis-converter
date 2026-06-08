import 'dart:convert';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kaminfeger_mobile/data/db/app_database.dart';
import 'package:kaminfeger_mobile/features/reports/application/pdf_report_generator.dart';
import 'package:kaminfeger_mobile/features/reports/application/report_data_aggregator.dart';

void main() {
  late AppDatabase database;

  setUp(() async {
    database = AppDatabase.forTesting(NativeDatabase.memory());
    await database.seedDevelopmentData();
  });

  tearDown(() async {
    await database.close();
  });

  test('generates a stable PDF structure snapshot', () async {
    final data = await ReportDataAggregator(
      database: database,
      tenantId: DevelopmentSeed.tenantId,
    ).load(DevelopmentSeed.workOrderInspectionId);

    final bytes = await const PdfReportGenerator().generateBytes(data!);
    final body = latin1.decode(bytes, allowInvalid: true);
    final pageObjectCount = RegExp(
      r'/Type\s*/Page(?!s)',
    ).allMatches(body).length;
    final hasPageTree = RegExp(r'/Type\s*/Pages').hasMatch(body);
    final structure = {
      'startsWithPdfHeader': body.startsWith('%PDF-'),
      'endsWithEof': body.trimRight().endsWith('%%EOF'),
      'containsPageTree': hasPageTree,
      'containsMediaBox': body.contains('/MediaBox'),
      'containsContents': body.contains('/Contents'),
      'pageObjectCount': pageObjectCount,
      'minimumBytes': bytes.length > 2500,
    };

    expect(structure, {
      'startsWithPdfHeader': true,
      'endsWithEof': true,
      'containsPageTree': true,
      'containsMediaBox': true,
      'containsContents': true,
      'pageObjectCount': greaterThanOrEqualTo(1),
      'minimumBytes': true,
    });
  });
}
