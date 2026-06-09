import 'dart:typed_data';

import 'package:flutter/widgets.dart';
import 'package:printing/printing.dart';

import 'pdf_report_generator.dart';
import 'report_data_aggregator.dart';

typedef SharePdfCallback =
    Future<bool> Function({
      required Uint8List bytes,
      String filename,
      Rect? bounds,
      String? subject,
      String? body,
      List<String>? emails,
    });

final class ReportShareService {
  const ReportShareService({
    this.generator = const PdfReportGenerator(),
    SharePdfCallback? sharePdf,
  }) : _sharePdf = sharePdf ?? Printing.sharePdf;

  final PdfReportGenerator generator;
  final SharePdfCallback _sharePdf;

  Future<bool> shareByEmail({
    required ReportData data,
    required String subject,
    required String body,
    Rect? bounds,
  }) async {
    final bytes = await generator.generateBytes(data);
    final order = data.header.workOrder;
    final customer = data.header.customer;
    final email = customer.email?.trim();

    return _sharePdf(
      bytes: bytes,
      filename: _filename(order.orderNumber),
      bounds: bounds,
      subject: subject,
      body: body,
      emails: email == null || email.isEmpty ? null : [email],
    );
  }

  String _filename(String orderNumber) {
    final safeOrderNumber = orderNumber
        .replaceAll(RegExp(r'[^A-Za-z0-9._-]+'), '-')
        .replaceAll(RegExp(r'-+'), '-')
        .replaceAll(RegExp(r'^-|-$'), '');
    return 'rapport-${safeOrderNumber.isEmpty ? 'auftrag' : safeOrderNumber}.pdf';
  }
}
