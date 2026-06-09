import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';

import 'package:share_plus/share_plus.dart';

import '../../../data/db/app_database.dart';
import 'report_data_aggregator.dart';

typedef InvoiceShareCallback = Future<ShareResult> Function(ShareParams params);

final class InvoiceDraft {
  const InvoiceDraft({
    required this.invoiceNumber,
    required this.orderNumber,
    required this.issuedOn,
    required this.dueOn,
    required this.recipientName,
    required this.billingAddress,
    required this.tenantName,
    required this.lines,
  });

  final String invoiceNumber;
  final String orderNumber;
  final DateTime issuedOn;
  final DateTime dueOn;
  final String recipientName;
  final String billingAddress;
  final String tenantName;
  final List<InvoiceDraftLine> lines;

  double get subtotal =>
      lines.fold(0, (sum, line) => sum + (line.totalPrice ?? 0));

  double get taxPointsTotal =>
      lines.fold(0, (sum, line) => sum + (line.taxPoints ?? 0));

  Map<String, Object?> toJson() {
    return {
      'invoiceNumber': invoiceNumber,
      'orderNumber': orderNumber,
      'issuedOn': issuedOn.toIso8601String(),
      'dueOn': dueOn.toIso8601String(),
      'recipientName': recipientName,
      'billingAddress': billingAddress,
      'tenantName': tenantName,
      'subtotal': subtotal,
      'taxPointsTotal': taxPointsTotal,
      'currency': 'CHF',
      'lines': lines.map((line) => line.toJson()).toList(growable: false),
    };
  }
}

final class InvoiceDraftLine {
  const InvoiceDraftLine({
    required this.sourceType,
    required this.sourceId,
    required this.description,
    required this.quantity,
    required this.unit,
    this.code,
    this.unitPrice,
    this.totalPrice,
    this.taxPoints,
    this.notes,
  });

  final String sourceType;
  final String sourceId;
  final String description;
  final double quantity;
  final String unit;
  final String? code;
  final double? unitPrice;
  final double? totalPrice;
  final double? taxPoints;
  final String? notes;

  Map<String, Object?> toJson() {
    return {
      'sourceType': sourceType,
      'sourceId': sourceId,
      'code': code,
      'description': description,
      'quantity': quantity,
      'unit': unit,
      'unitPrice': unitPrice,
      'totalPrice': totalPrice,
      'taxPoints': taxPoints,
      'notes': notes,
    };
  }
}

final class WorkOrderInvoiceExportService {
  WorkOrderInvoiceExportService({
    InvoiceShareCallback? share,
    DateTime Function()? now,
  }) : _share = share ?? SharePlus.instance.share,
       _now = now ?? DateTime.now;

  final InvoiceShareCallback _share;
  final DateTime Function() _now;

  InvoiceDraft buildDraft(ReportData data, {DateTime? issuedOn}) {
    final issued = _dateOnly(issuedOn ?? _now());
    final lines = _buildLines(data);
    if (lines.isEmpty) {
      throw StateError('Keine verrechenbaren Positionen vorhanden.');
    }

    return InvoiceDraft(
      invoiceNumber: 'RE-${data.header.workOrder.orderNumber}',
      orderNumber: data.header.workOrder.orderNumber,
      issuedOn: issued,
      dueOn: issued.add(const Duration(days: 30)),
      recipientName: data.header.customer.displayName,
      billingAddress: _billingAddress(data),
      tenantName: data.tenant.name,
      lines: lines,
    );
  }

  Uint8List buildJsonBytes(ReportData data, {DateTime? issuedOn}) {
    final draft = buildDraft(data, issuedOn: issuedOn);
    const encoder = JsonEncoder.withIndent('  ');
    return Uint8List.fromList(
      utf8.encode('${encoder.convert(draft.toJson())}\n'),
    );
  }

  Future<ShareResult> share(ReportData data, {Rect? bounds}) async {
    final draft = buildDraft(data);
    final bytes = buildJsonBytes(data, issuedOn: draft.issuedOn);
    final filename = filenameFor(draft);

    return _share(
      ShareParams(
        title: draft.invoiceNumber,
        subject: draft.invoiceNumber,
        sharePositionOrigin: bounds,
        files: [
          XFile.fromData(
            bytes,
            mimeType: 'application/json',
            name: filename,
            length: bytes.length,
            lastModified: _now(),
          ),
        ],
        fileNameOverrides: [filename],
      ),
    );
  }

  String filenameFor(InvoiceDraft draft) {
    final safeInvoiceNumber = draft.invoiceNumber
        .replaceAll(RegExp(r'[^A-Za-z0-9._-]+'), '-')
        .replaceAll(RegExp(r'-+'), '-')
        .replaceAll(RegExp(r'^-|-$'), '');
    return 'rechnung-${safeInvoiceNumber.isEmpty ? 'auftrag' : safeInvoiceNumber}.json';
  }

  List<InvoiceDraftLine> _buildLines(ReportData data) {
    final materialCatalogById = {
      for (final material in data.materialCatalog) material.id: material,
    };

    return [
      ...data.serviceLines.map(_serviceLine),
      ...data.materials.map(
        (usage) => _materialLine(
          usage,
          usage.materialId == null
              ? null
              : materialCatalogById[usage.materialId],
        ),
      ),
    ];
  }

  InvoiceDraftLine _serviceLine(WorkOrderServiceLineRow row) {
    final totalPrice = row.totalPrice ?? _total(row.quantity, row.unitPrice);
    return InvoiceDraftLine(
      sourceType: 'service',
      sourceId: row.id,
      code: row.code,
      description: row.name,
      quantity: row.quantity,
      unit: row.unit,
      unitPrice: row.unitPrice,
      totalPrice: totalPrice,
      taxPoints: row.taxPoints,
      notes: row.notes,
    );
  }

  InvoiceDraftLine _materialLine(
    WorkOrderMaterialRow usage,
    MaterialRow? catalogMaterial,
  ) {
    final unitPrice = catalogMaterial?.defaultPrice;
    return InvoiceDraftLine(
      sourceType: 'material',
      sourceId: usage.id,
      code: catalogMaterial?.sku,
      description: usage.name,
      quantity: usage.quantity,
      unit: usage.unit,
      unitPrice: unitPrice,
      totalPrice: _total(usage.quantity, unitPrice),
      notes: usage.notes,
    );
  }

  double? _total(double quantity, double? unitPrice) {
    return unitPrice == null ? null : quantity * unitPrice;
  }

  String _billingAddress(ReportData data) {
    final billingAddress = data.header.customer.billingAddress?.trim();
    if (billingAddress != null && billingAddress.isNotEmpty) {
      return billingAddress;
    }

    final object = data.header.object;
    return '${object.street} ${object.houseNumber}\n'
        '${object.postalCode} ${object.city}';
  }

  DateTime _dateOnly(DateTime value) {
    return DateTime.utc(value.year, value.month, value.day);
  }
}
