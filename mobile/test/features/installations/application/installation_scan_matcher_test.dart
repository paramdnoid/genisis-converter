import 'package:flutter_test/flutter_test.dart';
import 'package:kaminfeger_mobile/domain/entities/installation.dart';
import 'package:kaminfeger_mobile/features/installations/application/installation_scan_matcher.dart';

void main() {
  const matcher = InstallationScanMatcher();
  const installations = [
    Installation(
      id: 'installation-1',
      tenantId: 'tenant-1',
      objectId: 'object-1',
      type: 'fireplace',
      manufacturer: 'Rueegg',
      model: 'RIII 45',
      serialNumber: 'SN-45-2026',
    ),
  ];

  test('matches plain installation ids', () {
    final match = matcher.match(
      rawCode: ' installation-1 ',
      installations: installations,
    );

    expect(match?.installation.id, 'installation-1');
    expect(match?.matchKind, InstallationScanMatchKind.id);
  });

  test('matches installation ids from urls and json payloads', () {
    final fromUrl = matcher.match(
      rawCode: 'kaminfeger://app/installations/installation-1',
      installations: installations,
    );
    final fromJson = matcher.match(
      rawCode: '{"installationId":"installation-1"}',
      installations: installations,
    );

    expect(fromUrl?.installation.id, 'installation-1');
    expect(fromJson?.installation.id, 'installation-1');
  });

  test('matches serial numbers from query payloads', () {
    final match = matcher.match(
      rawCode: 'https://example.test/anlagen?serialNumber=SN-45-2026',
      installations: installations,
    );

    expect(match?.installation.id, 'installation-1');
    expect(match?.matchKind, InstallationScanMatchKind.serialNumber);
  });

  test('returns null for unknown codes', () {
    final match = matcher.match(
      rawCode: 'unknown-installation',
      installations: installations,
    );

    expect(match, isNull);
  });
}
