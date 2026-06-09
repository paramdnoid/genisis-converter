import 'dart:convert';

import '../../../domain/entities/installation.dart';

final class InstallationScanMatch {
  const InstallationScanMatch({
    required this.installation,
    required this.matchKind,
  });

  final Installation installation;
  final InstallationScanMatchKind matchKind;
}

enum InstallationScanMatchKind { id, serialNumber }

final class InstallationScanMatcher {
  const InstallationScanMatcher();

  InstallationScanMatch? match({
    required String rawCode,
    required List<Installation> installations,
  }) {
    final candidates = _extractCandidates(rawCode);
    if (candidates.isEmpty) {
      return null;
    }

    for (final candidate in candidates) {
      for (final installation in installations) {
        if (_normalize(installation.id) == candidate) {
          return InstallationScanMatch(
            installation: installation,
            matchKind: InstallationScanMatchKind.id,
          );
        }
      }
    }

    for (final candidate in candidates) {
      for (final installation in installations) {
        final serialNumber = installation.serialNumber;
        if (serialNumber != null && _normalize(serialNumber) == candidate) {
          return InstallationScanMatch(
            installation: installation,
            matchKind: InstallationScanMatchKind.serialNumber,
          );
        }
      }
    }

    return null;
  }
}

Set<String> _extractCandidates(String rawCode) {
  final trimmed = rawCode.trim();
  if (trimmed.isEmpty) {
    return const {};
  }

  final candidates = <String>{};
  void add(Object? value) {
    final normalized = _normalize(value?.toString() ?? '');
    if (normalized.isNotEmpty) {
      candidates.add(normalized);
    }
  }

  add(trimmed);

  final uri = Uri.tryParse(trimmed);
  if (uri != null) {
    for (final key in [
      'installationId',
      'installation_id',
      'anlageId',
      'anlage_id',
      'id',
      'serialNumber',
      'serial_number',
      'serial',
      'sn',
    ]) {
      add(uri.queryParameters[key]);
    }
    if (uri.pathSegments.isNotEmpty) {
      add(uri.pathSegments.last);
    }
  }

  final jsonValue = _tryDecodeJson(trimmed);
  if (jsonValue is Map) {
    for (final key in [
      'installationId',
      'installation_id',
      'anlageId',
      'anlage_id',
      'id',
      'serialNumber',
      'serial_number',
      'serial',
      'sn',
    ]) {
      add(jsonValue[key]);
    }
  }

  return candidates;
}

Object? _tryDecodeJson(String value) {
  try {
    return jsonDecode(value);
  } on FormatException {
    return null;
  }
}

String _normalize(String value) {
  return value.trim().toLowerCase();
}
