import 'dart:async';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kaminfeger_mobile/data/db/app_database.dart';
import 'package:kaminfeger_mobile/data/db/database_providers.dart';
import 'package:kaminfeger_mobile/domain/entities/measurement.dart';
import 'package:kaminfeger_mobile/features/measurements/application/bluetooth_measurement.dart';
import 'package:kaminfeger_mobile/features/measurements/application/measurement_providers.dart';
import 'package:kaminfeger_mobile/features/measurements/presentation/measurement_screen.dart';

import '../../helpers/test_app.dart';

void main() {
  late AppDatabase database;
  late _FakeBluetoothMeasurementClient bluetoothClient;

  setUp(() async {
    database = AppDatabase.forTesting(NativeDatabase.memory());
    await database.seedDevelopmentData();
    bluetoothClient = _FakeBluetoothMeasurementClient();
  });

  tearDown(() async {
    await bluetoothClient.close();
  });

  testWidgets('imports a bluetooth measurement into the local work order', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          appDatabaseProvider.overrideWithValue(database),
          databaseReadyProvider.overrideWith((_) async => database),
          bluetoothMeasurementClientProvider.overrideWithValue(bluetoothClient),
        ],
        child: localizedTestApp(
          home: const MeasurementScreen(
            workOrderId: DevelopmentSeed.workOrderInspectionId,
          ),
        ),
      ),
    );

    await _pumpUntilFound(tester, find.text('Bluetooth-Messgerät'));
    await tester.ensureVisible(find.text('Bluetooth-Messgerät'));
    await tester.pump(const Duration(milliseconds: 50));

    expect(find.text('Bluetooth-Messgerät'), findsOneWidget);
    await tester.ensureVisible(find.text('Scan starten'));
    await tester.tap(find.text('Scan starten'));
    await _pumpUntilFound(tester, find.text('Testo 300'));

    expect(find.text('Testo 300'), findsOneWidget);
    await tester.tap(find.byKey(const ValueKey('bluetooth-device-device-1')));
    await _pumpUntilFound(tester, find.text('18,0 ppm'));

    expect(find.text('CO'), findsWidgets);
    expect(find.text('18,0 ppm'), findsOneWidget);

    await tester.ensureVisible(find.text('Messwert übernehmen'));
    await tester.tap(find.text('Messwert übernehmen'));
    await _pumpUntilFound(
      tester,
      find.text('Bluetooth-Messwert lokal gespeichert.'),
    );

    expect(find.text('Bluetooth-Messwert lokal gespeichert.'), findsOneWidget);

    final rows =
        await (database.select(database.measurements)..where(
              (table) =>
                  table.tenantId.equals(DevelopmentSeed.tenantId) &
                  table.workOrderId.equals(
                    DevelopmentSeed.workOrderInspectionId,
                  ),
            ))
            .get();

    expect(rows, hasLength(1));
    expect(rows.single.measurementType, MeasurementType.co.value);
    expect(rows.single.value, 18);
    expect(rows.single.unit, 'ppm');
    expect(rows.single.deviceName, 'Testo 300');
    expect(rows.single.deviceSerial, 'T300-42');
    expect(rows.single.syncStatus, 'pending');

    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump(const Duration(milliseconds: 250));
  });
}

Future<void> _pumpUntilFound(
  WidgetTester tester,
  Finder finder, {
  int maxPumps = 40,
}) async {
  for (var i = 0; i < maxPumps; i += 1) {
    await tester.pump(const Duration(milliseconds: 50));
    if (finder.evaluate().isNotEmpty) {
      return;
    }
  }
  fail('Expected to find $finder after $maxPumps pumps.');
}

final class _FakeBluetoothMeasurementClient
    implements BluetoothMeasurementClient {
  final _devices =
      StreamController<List<BluetoothMeasurementDevice>>.broadcast();
  final _scanning = StreamController<bool>.broadcast();
  final _reading = BluetoothMeasurementReading(
    type: MeasurementType.co,
    value: 18,
    unit: 'ppm',
    deviceName: 'Testo 300',
    deviceSerial: 'T300-42',
    rawPayload: 'CO=18 ppm',
    measuredAt: DateTime.utc(2026, 6, 8, 8, 30),
  );

  @override
  Future<void> disconnect(String deviceId) async {}

  @override
  Future<bool> isSupported() async => true;

  @override
  Future<void> startScan() async {
    _scanning.add(true);
    _devices.add([
      BluetoothMeasurementDevice(
        id: 'device-1',
        name: 'Testo 300',
        rssi: -42,
        lastSeen: DateTime.utc(2026, 6, 8, 8, 30),
      ),
    ]);
    _scanning.add(false);
  }

  @override
  Future<void> stopScan() async {
    _scanning.add(false);
  }

  @override
  Stream<List<BluetoothMeasurementReading>> connectAndWatchReadings(
    String deviceId,
  ) {
    return Stream.value([_reading]);
  }

  @override
  Stream<List<BluetoothMeasurementDevice>> watchDevices() async* {
    yield const [];
    yield* _devices.stream;
  }

  @override
  Stream<bool> watchScanning() async* {
    yield false;
    yield* _scanning.stream;
  }

  Future<void> close() async {
    await _devices.close();
    await _scanning.close();
  }
}
