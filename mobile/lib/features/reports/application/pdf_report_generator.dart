import 'dart:typed_data';
import 'dart:io';

import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../../core/files/file_storage_service.dart';
import '../../../data/db/app_database.dart';
import '../../../l10n/generated/app_localizations_de.dart';
import 'report_data_aggregator.dart';

final _pdfL10n = AppLocalizationsDe();

final class PdfReportGenerator {
  const PdfReportGenerator({this.storage = const FileStorageService()});

  final FileStorageService storage;

  Future<Uint8List> generateBytes(ReportData data) async {
    final document = pw.Document();
    final order = data.header.workOrder;
    final customer = data.header.customer;
    final object = data.header.object;
    final template = data.reportTemplate;
    final accentColor = _templateColor(template?.primaryColor);
    final logo = _loadLocalImage(data.logoPhoto?.localPath);
    final signature = _loadLocalImage(data.signaturePhoto?.localPath);
    final decimal = NumberFormat.decimalPatternDigits(
      locale: 'de',
      decimalDigits: 1,
    );
    final quantity = NumberFormat.decimalPatternDigits(
      locale: 'de',
      decimalDigits: 2,
    );

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
                        '${_templateTitlePrefix(template)} ${order.orderNumber}',
                        style: pw.TextStyle(
                          fontSize: 24,
                          fontWeight: pw.FontWeight.bold,
                          color: accentColor,
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
          if (template?.includeCustomer ?? true)
            _section('Kunde und Objekt', [
              customer.displayName,
              '${object.street} ${object.houseNumber}, ${object.postalCode} ${object.city}',
              if (object.accessNotes != null) 'Zugang: ${object.accessNotes}',
              if (object.safetyNotes != null)
                'Sicherheit: ${object.safetyNotes}',
            ], accentColor),
          if (template?.includeInstallations ?? true)
            _table(
              'Anlagen',
              ['Typ', 'Hersteller/Modell', 'Standort'],
              data.installations
                  .map(
                    (row) => [
                      row.type,
                      [
                        row.manufacturer,
                        row.model,
                      ].whereType<String>().join(' '),
                      row.locationDescription ?? '',
                    ],
                  )
                  .toList(),
              accentColor,
            ),
          if (template?.includeMeasurements ?? true)
            _table(
              'Messwerte',
              ['Art', 'Wert', 'Einheit', 'Notiz'],
              data.measurements
                  .map(
                    (row) => [
                      row.measurementType,
                      decimal.format(row.value),
                      row.unit,
                      row.notes ?? '',
                    ],
                  )
                  .toList(),
              accentColor,
            ),
          if (template?.includeDefects ?? true)
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
              accentColor,
            ),
          if (template?.includeMaterials ?? true)
            _table(
              'Material',
              ['Bezeichnung', 'Menge', 'Einheit', 'Notiz'],
              data.materials
                  .map(
                    (row) => [
                      row.name,
                      quantity.format(row.quantity),
                      row.unit,
                      row.notes ?? '',
                    ],
                  )
                  .toList(),
              accentColor,
            ),
          if (template?.includeTimeEntries ?? true)
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
              accentColor,
            ),
          if (template?.includePhotos ?? true)
            _section(
              'Fotos',
              data.photos.isEmpty
                  ? ['Keine Fotos gespeichert.']
                  : data.photos
                        .map(
                          (photo) =>
                              '${photo.caption ?? photo.fileName}: ${photo.localPath}',
                        )
                        .toList(),
              accentColor,
            ),
          _section('Abschlussnotiz', [
            order.completionNotes ?? '-',
          ], accentColor),
          if (template?.includeSignature ?? true)
            _signatureSection(
              customerName: order.customerSignatureFileId == null
                  ? null
                  : data.signaturePhoto?.caption?.replaceFirst('Signatur ', ''),
              signature: signature,
              accentColor: accentColor,
            ),
        ],
        footer: template?.footerText == null
            ? null
            : (context) => pw.Align(
                alignment: pw.Alignment.centerRight,
                child: pw.Text(
                  '${template!.footerText!} · ${context.pageNumber}/${context.pagesCount}',
                  style: const pw.TextStyle(
                    fontSize: 8,
                    color: PdfColors.grey700,
                  ),
                ),
              ),
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

  pw.Widget _section(String title, List<String> lines, PdfColor accentColor) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 18),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            title,
            style: pw.TextStyle(
              fontSize: 16,
              fontWeight: pw.FontWeight.bold,
              color: accentColor,
            ),
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
    required PdfColor accentColor,
  }) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(top: 8),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            _pdfL10n.customerSignatureTitle,
            style: pw.TextStyle(
              fontSize: 16,
              fontWeight: pw.FontWeight.bold,
              color: accentColor,
            ),
          ),
          pw.SizedBox(height: 6),
          pw.Text('${_pdfL10n.pdfSignerLabel}: ${customerName ?? '-'}'),
          pw.SizedBox(height: 8),
          if (signature == null)
            pw.Text(_pdfL10n.pdfNoSignatureMessage)
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
    PdfColor accentColor,
  ) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 18),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            title,
            style: pw.TextStyle(
              fontSize: 16,
              fontWeight: pw.FontWeight.bold,
              color: accentColor,
            ),
          ),
          pw.SizedBox(height: 6),
          if (rows.isEmpty)
            pw.Text(_pdfL10n.pdfNoEntriesMessage)
          else
            pw.TableHelper.fromTextArray(
              headers: headers,
              data: rows,
              headerDecoration: pw.BoxDecoration(
                color: _mutedHeaderColor(accentColor),
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

  String _templateTitlePrefix(ReportTemplateRow? template) {
    final configured = template?.titlePrefix.trim();
    return configured == null || configured.isEmpty ? 'Rapport' : configured;
  }

  PdfColor _templateColor(String? configured) {
    final value = configured?.trim();
    if (value == null || value.isEmpty) {
      return PdfColors.grey800;
    }

    final hex = value.startsWith('#') ? value.substring(1) : value;
    if (!RegExp(r'^[0-9a-fA-F]{6}$').hasMatch(hex)) {
      return PdfColors.grey800;
    }

    final red = int.parse(hex.substring(0, 2), radix: 16) / 255;
    final green = int.parse(hex.substring(2, 4), radix: 16) / 255;
    final blue = int.parse(hex.substring(4, 6), radix: 16) / 255;
    return PdfColor(red, green, blue);
  }

  PdfColor _mutedHeaderColor(PdfColor accentColor) {
    return PdfColor(
      0.88 + (accentColor.red * 0.12),
      0.88 + (accentColor.green * 0.12),
      0.88 + (accentColor.blue * 0.12),
    );
  }
}
