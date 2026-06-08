import 'dart:typed_data';
import 'dart:io';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../../core/files/file_storage_service.dart';
import 'report_data_aggregator.dart';

final class PdfReportGenerator {
  const PdfReportGenerator({this.storage = const FileStorageService()});

  final FileStorageService storage;

  Future<Uint8List> generateBytes(ReportData data) async {
    final document = pw.Document();
    final order = data.header.workOrder;
    final customer = data.header.customer;
    final object = data.header.object;
    final logo = _loadLocalImage(data.logoPhoto?.localPath);
    final signature = _loadLocalImage(data.signaturePhoto?.localPath);

    document.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        build: (context) => [
          pw.Header(
            level: 0,
            child: pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                _logoBlock(data, logo),
                pw.SizedBox(width: 16),
                pw.Expanded(
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        'Rapport ${order.orderNumber}',
                        style: pw.TextStyle(
                          fontSize: 24,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.Text(order.title),
                      pw.SizedBox(height: 8),
                      pw.Text(data.tenant.name),
                      pw.Text(
                        '${data.tenant.address}, ${data.tenant.postalCode} ${data.tenant.city}',
                      ),
                      pw.Text('${data.tenant.phone} · ${data.tenant.email}'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          _section('Kunde und Objekt', [
            customer.displayName,
            '${object.street} ${object.houseNumber}, ${object.postalCode} ${object.city}',
            if (object.accessNotes != null) 'Zugang: ${object.accessNotes}',
            if (object.safetyNotes != null) 'Sicherheit: ${object.safetyNotes}',
          ]),
          _table(
            'Anlagen',
            ['Typ', 'Hersteller/Modell', 'Standort'],
            data.installations
                .map(
                  (row) => [
                    row.type,
                    [row.manufacturer, row.model].whereType<String>().join(' '),
                    row.locationDescription ?? '',
                  ],
                )
                .toList(),
          ),
          _table(
            'Messwerte',
            ['Art', 'Wert', 'Einheit', 'Notiz'],
            data.measurements
                .map(
                  (row) => [
                    row.measurementType,
                    row.value.toStringAsFixed(1),
                    row.unit,
                    row.notes ?? '',
                  ],
                )
                .toList(),
          ),
          _table(
            'Mängel',
            ['Schweregrad', 'Titel', 'Beschreibung', 'Massnahme'],
            data.defects
                .map(
                  (row) => [
                    row.severity,
                    row.title,
                    row.description,
                    row.recommendedAction ?? '',
                  ],
                )
                .toList(),
          ),
          _table(
            'Material',
            ['Bezeichnung', 'Menge', 'Einheit', 'Notiz'],
            data.materials
                .map(
                  (row) => [
                    row.name,
                    row.quantity.toStringAsFixed(2),
                    row.unit,
                    row.notes ?? '',
                  ],
                )
                .toList(),
          ),
          _table(
            'Zeiten',
            ['Typ', 'Start', 'Ende', 'Minuten'],
            data.timeEntries
                .map(
                  (row) => [
                    row.type,
                    row.startTime,
                    row.endTime ?? '',
                    '${row.durationMinutes ?? ''}',
                  ],
                )
                .toList(),
          ),
          _section(
            'Fotos und Signatur',
            data.photos.isEmpty
                ? ['Keine Fotos gespeichert.']
                : data.photos
                      .map(
                        (photo) =>
                            '${photo.caption ?? photo.fileName}: ${photo.localPath}',
                      )
                      .toList(),
          ),
          _section('Abschlussnotiz', [order.completionNotes ?? '-']),
          _signatureSection(
            customerName: order.customerSignatureFileId == null
                ? null
                : data.signaturePhoto?.caption?.replaceFirst('Signatur ', ''),
            signature: signature,
          ),
        ],
      ),
    );

    return document.save();
  }

  Future<StoredFile> save({
    required ReportData data,
    required String tenantId,
    required String workOrderId,
  }) async {
    final bytes = await generateBytes(data);
    final orderNumber = data.header.workOrder.orderNumber.replaceAll('/', '-');
    return storage.writeBytesIntoWorkOrder(
      tenantId: tenantId,
      workOrderId: workOrderId,
      bytes: bytes,
      fileName: 'rapport-$orderNumber.pdf',
      mimeType: 'application/pdf',
    );
  }

  pw.Widget _section(String title, List<String> lines) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 18),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            title,
            style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
          ),
          pw.SizedBox(height: 6),
          ...lines.map((line) => pw.Text(line)),
        ],
      ),
    );
  }

  pw.Widget _logoBlock(ReportData data, pw.MemoryImage? logo) {
    if (logo != null) {
      return pw.Container(
        width: 76,
        height: 76,
        alignment: pw.Alignment.center,
        child: pw.Image(logo, fit: pw.BoxFit.contain),
      );
    }

    final parts = data.tenant.name
        .split(RegExp(r'\s+'))
        .where((part) => part.isNotEmpty)
        .take(2)
        .map((part) => part[0].toUpperCase())
        .join();

    return pw.Container(
      width: 76,
      height: 76,
      alignment: pw.Alignment.center,
      decoration: pw.BoxDecoration(
        border: pw.Border.all(color: PdfColors.grey600),
        borderRadius: pw.BorderRadius.circular(6),
      ),
      child: pw.Text(
        parts.isEmpty ? 'KF' : parts,
        style: pw.TextStyle(fontSize: 22, fontWeight: pw.FontWeight.bold),
      ),
    );
  }

  pw.Widget _signatureSection({
    required String? customerName,
    required pw.MemoryImage? signature,
  }) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(top: 8),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            'Kundensignatur',
            style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
          ),
          pw.SizedBox(height: 6),
          pw.Text('Unterzeichner: ${customerName ?? '-'}'),
          pw.SizedBox(height: 8),
          if (signature == null)
            pw.Text('Keine Signatur gespeichert.')
          else
            pw.Container(
              width: 220,
              height: 90,
              alignment: pw.Alignment.centerLeft,
              child: pw.Image(signature, fit: pw.BoxFit.contain),
            ),
        ],
      ),
    );
  }

  pw.MemoryImage? _loadLocalImage(String? imagePath) {
    if (imagePath == null || imagePath.trim().isEmpty) {
      return null;
    }

    final file = File(imagePath);
    if (!file.existsSync()) {
      return null;
    }

    return pw.MemoryImage(file.readAsBytesSync());
  }

  pw.Widget _table(
    String title,
    List<String> headers,
    List<List<String>> rows,
  ) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 18),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            title,
            style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
          ),
          pw.SizedBox(height: 6),
          if (rows.isEmpty)
            pw.Text('Keine Einträge.')
          else
            pw.TableHelper.fromTextArray(
              headers: headers,
              data: rows,
              headerDecoration: const pw.BoxDecoration(
                color: PdfColors.grey300,
              ),
              cellAlignment: pw.Alignment.centerLeft,
              cellStyle: const pw.TextStyle(fontSize: 9),
              headerStyle: pw.TextStyle(
                fontSize: 9,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
        ],
      ),
    );
  }
}
