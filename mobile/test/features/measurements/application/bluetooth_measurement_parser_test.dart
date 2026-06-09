import 'package:flutter_test/flutter_test.dart';
import 'package:kaminfeger_mobile/domain/entities/measurement.dart';
import 'package:kaminfeger_mobile/features/measurements/application/bluetooth_measurement.dart';

void main() {
  const parser = BluetoothMeasurementParser();

  test('parses key value payloads from BLE measuring devices', () {
    final readings = parser.parse(
      'DEVICE=Testo 300; SERIAL=T300-42; CO=18 ppm; O2=20.9 %; TEMP=132 C',
    );

    expect(readings, hasLength(3));
    expect(readings.map((reading) => reading.type), [
      MeasurementType.co,
      MeasurementType.o2,
      MeasurementType.temperature,
    ]);
    expect(readings[0].value, 18);
    expect(readings[0].unit, 'ppm');
    expect(readings[1].value, 20.9);
    expect(readings[1].unit, '%');
    expect(readings[2].unit, '°C');
    expect(readings[0].deviceName, 'Testo 300');
    expect(readings[0].deviceSerial, 'T300-42');
  });

  test('parses nested json readings with inherited device metadata', () {
    final readings = parser.parse('''
      {
        "deviceName": "Woehler A 450",
        "serial": "A450-99",
        "readings": [
          {"type": "co", "value": "7,5", "unit": "ppm"},
          {"type": "draft", "value": -4.2, "unit": "Pa"}
        ]
      }
      ''');

    expect(readings, hasLength(2));
    expect(readings[0].type, MeasurementType.co);
    expect(readings[0].value, 7.5);
    expect(readings[0].deviceName, 'Woehler A 450');
    expect(readings[0].deviceSerial, 'A450-99');
    expect(readings[1].type, MeasurementType.draft);
    expect(readings[1].unit, 'Pa');
  });
}
