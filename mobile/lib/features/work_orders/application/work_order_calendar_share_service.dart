import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';

import 'package:share_plus/share_plus.dart';

import '../../../domain/entities/work_order_detail.dart';

typedef CalendarShareCallback =
    Future<ShareResult> Function(ShareParams params);

final class WorkOrderCalendarShareService {
  WorkOrderCalendarShareService({
    CalendarShareCallback? share,
    DateTime Function()? now,
  }) : _share = share ?? SharePlus.instance.share,
       _now = now ?? DateTime.now;

  final CalendarShareCallback _share;
  final DateTime Function() _now;

  Future<ShareResult> share(WorkOrderDetail detail, {Rect? bounds}) async {
    final filename = filenameFor(detail);
    final ics = buildIcs(detail);
    final bytes = Uint8List.fromList(utf8.encode(ics));

    return _share(
      ShareParams(
        title: detail.workOrder.title,
        subject: detail.workOrder.title,
        sharePositionOrigin: bounds,
        files: [
          XFile.fromData(
            bytes,
            mimeType: 'text/calendar',
            name: filename,
            length: bytes.length,
            lastModified: _now(),
          ),
        ],
        fileNameOverrides: [filename],
      ),
    );
  }

  String buildIcs(WorkOrderDetail detail) {
    final order = detail.workOrder;
    final scheduledStart = order.scheduledStart;
    if (scheduledStart == null) {
      throw StateError('Work order has no scheduled start.');
    }

    final scheduledEnd = order.scheduledEnd;
    final end = scheduledEnd == null || !scheduledEnd.isAfter(scheduledStart)
        ? scheduledStart.add(const Duration(hours: 1))
        : scheduledEnd;
    final summary = '${order.orderNumber} - ${order.title}';
    final description = [
      'Auftrag: ${order.orderNumber}',
      'Kunde: ${detail.customer.displayName}',
      'Objekt: ${detail.object.name}',
      'Adresse: ${detail.object.addressLine}',
      if (order.description?.trim().isNotEmpty ?? false)
        'Beschreibung: ${order.description!.trim()}',
      if (detail.object.accessNotes?.trim().isNotEmpty ?? false)
        'Zugang: ${detail.object.accessNotes!.trim()}',
    ].join('\n');
    final lines = [
      'BEGIN:VCALENDAR',
      'VERSION:2.0',
      'PRODID:-//Genisis Converter//Kaminfeger Mobile//DE',
      'CALSCALE:GREGORIAN',
      'METHOD:PUBLISH',
      'BEGIN:VEVENT',
      _line('UID', '${order.id}@kaminfeger-mobile'),
      _line('DTSTAMP', _formatUtc(_now())),
      _line('DTSTART', _formatUtc(scheduledStart)),
      _line('DTEND', _formatUtc(end)),
      _line('SUMMARY', summary),
      _line('LOCATION', detail.object.addressLine),
      _line('DESCRIPTION', description),
      'STATUS:CONFIRMED',
      'END:VEVENT',
      'END:VCALENDAR',
    ];

    return '${lines.join('\r\n')}\r\n';
  }

  String filenameFor(WorkOrderDetail detail) {
    final safeOrderNumber = detail.workOrder.orderNumber
        .replaceAll(RegExp(r'[^A-Za-z0-9._-]+'), '-')
        .replaceAll(RegExp(r'-+'), '-')
        .replaceAll(RegExp(r'^-|-$'), '');
    return 'termin-${safeOrderNumber.isEmpty ? 'auftrag' : safeOrderNumber}.ics';
  }

  String _line(String name, String value) {
    return _fold('$name:${_escapeText(value)}');
  }

  String _escapeText(String value) {
    return value
        .replaceAll(r'\', r'\\')
        .replaceAll('\r\n', r'\n')
        .replaceAll('\n', r'\n')
        .replaceAll('\r', r'\n')
        .replaceAll(';', r'\;')
        .replaceAll(',', r'\,');
  }

  String _fold(String line) {
    const limit = 75;
    if (line.length <= limit) {
      return line;
    }

    final buffer = StringBuffer();
    var current = line;
    while (current.length > limit) {
      buffer
        ..write(current.substring(0, limit))
        ..write('\r\n ');
      current = current.substring(limit);
    }
    buffer.write(current);
    return buffer.toString();
  }

  String _formatUtc(DateTime value) {
    final utc = value.toUtc();
    String two(int number) => number.toString().padLeft(2, '0');
    return '${utc.year}${two(utc.month)}${two(utc.day)}T'
        '${two(utc.hour)}${two(utc.minute)}${two(utc.second)}Z';
  }
}
