import 'dart:convert';

import '../../../domain/entities/measurement.dart';

final class BluetoothMeasurementDevice {
  const BluetoothMeasurementDevice({
    required this.id,
    required this.name,
    required this.rssi,
    required this.lastSeen,
    this.serial,
    this.connectable = true,
  });

  final String id;
  final String name;
  final String? serial;
  final int rssi;
  final DateTime lastSeen;
  final bool connectable;

  String get displayName => name.trim().isEmpty ? id : name.trim();
}

final class BluetoothMeasurementReading {
  const BluetoothMeasurementReading({
    required this.type,
    required this.value,
    required this.unit,
    required this.rawPayload,
    required this.measuredAt,
    this.deviceName,
    this.deviceSerial,
  });

  final MeasurementType type;
  final double value;
  final String unit;
  final String rawPayload;
  final DateTime measuredAt;
  final String? deviceName;
  final String? deviceSerial;

  MeasurementDraft toDraft({
    required String workOrderId,
    String? installationId,
  }) {
    return MeasurementDraft(
      workOrderId: workOrderId,
      installationId: installationId,
      type: type,
      value: value,
      unit: unit,
      deviceName: deviceName,
      deviceSerial: deviceSerial,
    );
  }
}

abstract interface class BluetoothMeasurementClient {
  Stream<List<BluetoothMeasurementDevice>> watchDevices();

  Stream<bool> watchScanning();

  Future<bool> isSupported();

  Future<void> startScan();

  Future<void> stopScan();

  Stream<List<BluetoothMeasurementReading>> connectAndWatchReadings(
    String deviceId,
  );

  Future<void> disconnect(String deviceId);
}

final class BluetoothMeasurementParser {
  const BluetoothMeasurementParser();

  List<BluetoothMeasurementReading> parseBytes(
    List<int> bytes, {
    String? deviceName,
    String? deviceSerial,
  }) {
    final payload = utf8.decode(bytes, allowMalformed: true);
    return parse(payload, deviceName: deviceName, deviceSerial: deviceSerial);
  }

  List<BluetoothMeasurementReading> parse(
    String payload, {
    String? deviceName,
    String? deviceSerial,
  }) {
    final trimmed = payload.trim();
    if (trimmed.isEmpty) {
      return const [];
    }

    final jsonReadings = _tryParseJson(
      trimmed,
      deviceName: deviceName,
      deviceSerial: deviceSerial,
    );
    if (jsonReadings.isNotEmpty) {
      return jsonReadings;
    }

    return _parseKeyValuePayload(
      trimmed,
      deviceName: deviceName,
      deviceSerial: deviceSerial,
    );
  }

  List<BluetoothMeasurementReading> _tryParseJson(
    String payload, {
    String? deviceName,
    String? deviceSerial,
  }) {
    try {
      final decoded = jsonDecode(payload);
      return _parseJsonValue(
        decoded,
        rawPayload: payload,
        deviceName: deviceName,
        deviceSerial: deviceSerial,
      );
    } on FormatException {
      return const [];
    }
  }

  List<BluetoothMeasurementReading> _parseJsonValue(
    Object? value, {
    required String rawPayload,
    String? deviceName,
    String? deviceSerial,
  }) {
    if (value is List) {
      return value
          .expand(
            (entry) => _parseJsonValue(
              entry,
              rawPayload: rawPayload,
              deviceName: deviceName,
              deviceSerial: deviceSerial,
            ),
          )
          .toList(growable: false);
    }

    if (value is! Map) {
      return const [];
    }

    final map = value.cast<String, Object?>();
    final inheritedDeviceName =
        _stringValue(
          map['deviceName'] ?? map['device'] ?? map['name'] ?? map['model'],
        ) ??
        deviceName;
    final inheritedDeviceSerial =
        _stringValue(map['deviceSerial'] ?? map['serial'] ?? map['sn']) ??
        deviceSerial;
    final nested = map['readings'] ?? map['measurements'];

    if (nested is List) {
      return nested
          .expand(
            (entry) => _parseJsonValue(
              entry,
              rawPayload: rawPayload,
              deviceName: inheritedDeviceName,
              deviceSerial: inheritedDeviceSerial,
            ),
          )
          .toList(growable: false);
    }

    final type = _typeForKey(
      _stringValue(
        map['measurementType'] ?? map['measurement_type'] ?? map['type'],
      ),
    );
    final rawValue = _doubleValue(map['value']);
    if (type == null || rawValue == null) {
      return const [];
    }

    return [
      BluetoothMeasurementReading(
        type: type,
        value: rawValue,
        unit: _normalizeUnit(
          _stringValue(map['unit']),
          MeasurementRules.forType(type).defaultUnit,
        ),
        deviceName: inheritedDeviceName,
        deviceSerial: inheritedDeviceSerial,
        rawPayload: rawPayload,
        measuredAt: DateTime.now().toUtc(),
      ),
    ];
  }

  List<BluetoothMeasurementReading> _parseKeyValuePayload(
    String payload, {
    String? deviceName,
    String? deviceSerial,
  }) {
    final metadata = _extractMetadata(payload);
    final resolvedDeviceName = metadata.deviceName ?? deviceName;
    final resolvedDeviceSerial = metadata.deviceSerial ?? deviceSerial;
    final readings = <BluetoothMeasurementReading>[];
    final segments = payload
        .split(RegExp(r'[;\r\n]+'))
        .map((segment) => segment.trim())
        .where((segment) => segment.isNotEmpty);

    for (final segment in segments) {
      final match = RegExp(
        r'^\s*([A-Za-z0-9_./ äöüÄÖÜ-]+)\s*[:=]\s*(.+?)\s*$',
      ).firstMatch(segment);
      if (match == null) {
        continue;
      }

      final key = match.group(1)?.trim();
      final body = match.group(2)?.trim() ?? '';
      if (_isMetadataKey(key)) {
        continue;
      }

      final type = _typeForKey(key);
      if (type == null) {
        continue;
      }

      final valueMatch = RegExp(
        r'([-+]?\d+(?:[.,]\d+)?)\s*([A-Za-z%°/0-9³]*)',
      ).firstMatch(body);
      if (valueMatch == null) {
        continue;
      }

      final value = double.tryParse(valueMatch.group(1)!.replaceAll(',', '.'));
      if (value == null) {
        continue;
      }

      readings.add(
        BluetoothMeasurementReading(
          type: type,
          value: value,
          unit: _normalizeUnit(
            valueMatch.group(2),
            MeasurementRules.forType(type).defaultUnit,
          ),
          deviceName: resolvedDeviceName,
          deviceSerial: resolvedDeviceSerial,
          rawPayload: payload,
          measuredAt: DateTime.now().toUtc(),
        ),
      );
    }

    return readings;
  }

  _BluetoothMeasurementMetadata _extractMetadata(String payload) {
    String? deviceName;
    String? deviceSerial;
    final segments = payload
        .split(RegExp(r'[;\r\n]+'))
        .map((segment) => segment.trim())
        .where((segment) => segment.isNotEmpty);

    for (final segment in segments) {
      final match = RegExp(
        r'^\s*([A-Za-z0-9_./ äöüÄÖÜ-]+)\s*[:=]\s*(.+?)\s*$',
      ).firstMatch(segment);
      final key = match?.group(1)?.trim();
      final value = match?.group(2)?.trim();
      if (key == null || value == null || value.isEmpty) {
        continue;
      }

      final normalized = _normalizeKey(key);
      if (normalized == 'device' ||
          normalized == 'devicename' ||
          normalized == 'name' ||
          normalized == 'model') {
        deviceName = value;
      } else if (normalized == 'serial' ||
          normalized == 'deviceserial' ||
          normalized == 'sn') {
        deviceSerial = value;
      }
    }

    return _BluetoothMeasurementMetadata(deviceName, deviceSerial);
  }

  bool _isMetadataKey(String? key) {
    final normalized = _normalizeKey(key);
    return normalized == 'device' ||
        normalized == 'devicename' ||
        normalized == 'name' ||
        normalized == 'model' ||
        normalized == 'serial' ||
        normalized == 'deviceserial' ||
        normalized == 'sn';
  }

  MeasurementType? _typeForKey(String? key) {
    final normalized = _normalizeKey(key);
    return switch (normalized) {
      'co' => MeasurementType.co,
      'co2' => MeasurementType.co2,
      'o2' => MeasurementType.o2,
      'temp' ||
      't' ||
      'temperature' ||
      'abgastemperatur' => MeasurementType.temperature,
      'draft' || 'zug' || 'kaminzug' => MeasurementType.draft,
      'soot' || 'russ' || 'russzahl' => MeasurementType.soot,
      'eff' || 'efficiency' || 'wirkungsgrad' => MeasurementType.efficiency,
      'pressure' || 'druck' => MeasurementType.pressure,
      'other' || 'sonstige' => MeasurementType.other,
      _ => null,
    };
  }

  String _normalizeUnit(String? unit, String fallback) {
    final raw = unit?.trim();
    if (raw == null || raw.isEmpty) {
      return fallback;
    }

    final compact = raw.replaceAll(' ', '').toLowerCase();
    return switch (compact) {
      '%' => '%',
      'ppm' => 'ppm',
      'mg/m3' || 'mg/m³' || 'mgm3' => 'mg/m3',
      'c' || '°c' || 'degc' || 'celsius' => '°C',
      'pa' => 'Pa',
      'mbar' => 'mbar',
      'index' || 'russzahl' => 'index',
      'wert' => 'Wert',
      _ => raw,
    };
  }

  String _normalizeKey(String? key) {
    return (key ?? '').trim().toLowerCase().replaceAll(
      RegExp(r'[\s_\-./]+'),
      '',
    );
  }

  String? _stringValue(Object? value) {
    if (value == null) {
      return null;
    }
    final text = value.toString().trim();
    return text.isEmpty ? null : text;
  }

  double? _doubleValue(Object? value) {
    if (value is num) {
      return value.toDouble();
    }
    if (value is String) {
      return double.tryParse(value.trim().replaceAll(',', '.'));
    }
    return null;
  }
}

final class _BluetoothMeasurementMetadata {
  const _BluetoothMeasurementMetadata(this.deviceName, this.deviceSerial);

  final String? deviceName;
  final String? deviceSerial;
}
