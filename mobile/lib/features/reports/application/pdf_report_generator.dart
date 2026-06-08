import 'dart:typed_data';

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

    document.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        build: (context) => [
          pw.Header(
            level: 0,
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
