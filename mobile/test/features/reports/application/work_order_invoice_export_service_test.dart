import 'dart:convert';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kaminfeger_mobile/data/db/app_database.dart';
import 'package:kaminfeger_mobile/data/repositories/drift_material_repository.dart';
import 'package:kaminfeger_mobile/domain/entities/material_usage.dart';
import 'package:kaminfeger_mobile/features/reports/application/report_data_aggregator.dart';
import 'package:kaminfeger_mobile/features/reports/application/work_order_invoice_export_service.dart';
import 'package:share_plus/share_plus.dart';

void main() {
  late AppDatabase database;

  setUp(() async {
    database = AppDatabase.forTesting(NativeDatabase.memory());
    await database.seedDevelopmentData();
  });

  tearDown(() async {
    await database.close();
  });

  test(
    'builds and shares invoice draft JSON from local work order data',
    () async {
      await database.workOrderDao.createServiceLineLocal(
        tenantId: DevelopmentSeed.tenantId,
        workOrderId: DevelopmentSeed.workOrderInspectionId,
        tariffCatalogItemId: DevelopmentSeed.tariffCatalogInspectionId,
        code: 'K-100',
        name: 'Jahreskontrolle Holzfeuerung',
        quantity: 1,
        unit: 'Pauschale',
        unitPrice: 120,
        taxPoints: 12,
      );
      await DriftMaterialRepository(
        database: database,
        tenantId: DevelopmentSeed.tenantId,
      ).createUsage(
        const WorkOrderMaterialDraft(
          workOrderId: DevelopmentSeed.workOrderInspectionId,
          materialId: DevelopmentSeed.materialCleaningId,
          name: 'Reinigungspauschale Kleinauftrag',
          quantity: 2,
          unit: 'Stueck',
        ),
      );
      final data = await ReportDataAggregator(
        database: database,
        tenantId: DevelopmentSeed.tenantId,
      ).load(DevelopmentSeed.workOrderInspectionId);
      final captured = _CapturedInvoiceShare();
      final service = WorkOrderInvoiceExportService(
        share: captured.call,
        now: () => DateTime.utc(2026, 1, 5, 12),
      );

      final draft = service.buildDraft(data!);
      final result = await service.share(data);

      expect(result.status, ShareResultStatus.success);
      expect(draft.invoiceNumber, 'RE-WO-2026-0001');
      expect(draft.billingAddress, 'Im Ried 7\n8610 Uster');
      expect(draft.lines, hasLength(2));
      expect(draft.subtotal, 290);
      expect(draft.taxPointsTotal, 12);
      expect(captured.params, isNotNull);
      expect(captured.params!.fileNameOverrides, [
        'rechnung-RE-WO-2026-0001.json',
      ]);

      final files = captured.params!.files;
      expect(files, hasLength(1));
      expect(files!.single.mimeType, 'application/json');
      final payload =
          jsonDecode(utf8.decode(await files.single.readAsBytes()))
              as Map<String, Object?>;
      final lines = payload['lines'] as List<Object?>;

      expect(payload['invoiceNumber'], 'RE-WO-2026-0001');
      expect(payload['orderNumber'], 'WO-2026-0001');
      expect(payload['issuedOn'], '2026-01-05T00:00:00.000Z');
      expect(payload['dueOn'], '2026-02-04T00:00:00.000Z');
      expect(payload['subtotal'], 290);
      expect(lines.map((line) => (line! as Map)['sourceType']), [
        'service',
        'material',
      ]);
    },
  );
}

final class _CapturedInvoiceShare {
  ShareParams? params;

  Future<ShareResult> call(ShareParams params) async {
    this.params = params;
    return const ShareResult('invoice', ShareResultStatus.success);
  }
}
