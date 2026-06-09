import 'dart:async';

import 'package:flutter_blue_plus/flutter_blue_plus.dart' as fbp;

import '../../../core/permissions/permission_service.dart';
import 'bluetooth_measurement.dart';

final class FlutterBluePlusMeasurementClient
    implements BluetoothMeasurementClient {
  FlutterBluePlusMeasurementClient({
    BluetoothMeasurementParser? parser,
    PermissionService? permissionService,
    this.scanTimeout = const Duration(seconds: 12),
    this.connectionTimeout = const Duration(seconds: 15),
  }) : _parser = parser ?? const BluetoothMeasurementParser(),
       _permissionService = permissionService ?? const PermissionService();

  final BluetoothMeasurementParser _parser;
  final PermissionService _permissionService;
  final Duration scanTimeout;
  final Duration connectionTimeout;

  @override
  Future<bool> isSupported() {
    return fbp.FlutterBluePlus.isSupported;
  }

  @override
  Stream<List<BluetoothMeasurementDevice>> watchDevices() {
    return fbp.FlutterBluePlus.scanResults.map((results) {
      return results
          .map((result) {
            final deviceName = _deviceName(result);
            return BluetoothMeasurementDevice(
              id: result.device.remoteId.str,
              name: deviceName,
              rssi: result.rssi,
              lastSeen: result.timeStamp,
              connectable: result.advertisementData.connectable,
            );
          })
          .where((device) => device.connectable)
          .toList(growable: false);
    });
  }

  @override
  Stream<bool> watchScanning() {
    return fbp.FlutterBluePlus.isScanning;
  }

  @override
  Future<void> startScan() async {
    await _permissionService.require(AppPermission.bluetoothScan);
    await _permissionService.require(AppPermission.bluetoothConnect);

    if (!await fbp.FlutterBluePlus.isSupported) {
      throw StateError('Bluetooth wird auf diesem Gerät nicht unterstützt.');
    }

    await fbp.FlutterBluePlus.adapterState
        .where((state) => state == fbp.BluetoothAdapterState.on)
        .first
        .timeout(
          const Duration(seconds: 8),
          onTimeout: () =>
              throw StateError('Bluetooth ist nicht eingeschaltet.'),
        );

    await fbp.FlutterBluePlus.startScan(
      timeout: scanTimeout,
      continuousUpdates: true,
      removeIfGone: const Duration(seconds: 30),
      androidUsesFineLocation: false,
    );
  }

  @override
  Future<void> stopScan() {
    return fbp.FlutterBluePlus.stopScan();
  }

  @override
  Stream<List<BluetoothMeasurementReading>> connectAndWatchReadings(
    String deviceId,
  ) {
    final controller = StreamController<List<BluetoothMeasurementReading>>();
    final subscriptions = <StreamSubscription<void>>[];
    final device = fbp.BluetoothDevice.fromId(deviceId);

    Future<void>(() async {
      try {
        await _permissionService.require(AppPermission.bluetoothConnect);
        await stopScan();
        await device.connect(
          license: fbp.License.commercial,
          timeout: connectionTimeout,
        );
        final services = await device.discoverServices();
        final characteristics = services
            .expand((service) => service.characteristics)
            .where(
              (characteristic) =>
                  characteristic.properties.notify ||
                  characteristic.properties.indicate ||
                  characteristic.properties.read,
            )
            .toList(growable: false);

        for (final characteristic in characteristics) {
          final properties = characteristic.properties;
          if (properties.notify || properties.indicate) {
            final subscription = characteristic.onValueReceived.listen(
              (bytes) => _emitParsedReadings(controller, device, bytes),
              onError: controller.addError,
            );
            subscriptions.add(subscription);
            device.cancelWhenDisconnected(subscription);
            await characteristic.setNotifyValue(true);
          }

          if (properties.read) {
            final bytes = await characteristic.read();
            _emitParsedReadings(controller, device, bytes);
          }
        }

        if (characteristics.isEmpty) {
          controller.addError(
            StateError('Keine lesbaren Messwert-Characteristics gefunden.'),
          );
        }
      } catch (error, stackTrace) {
        controller.addError(error, stackTrace);
      }
    });

    controller.onCancel = () async {
      for (final subscription in subscriptions) {
        await subscription.cancel();
      }
      if (device.isConnected) {
        await device.disconnect(queue: false);
      }
    };

    return controller.stream;
  }

  @override
  Future<void> disconnect(String deviceId) {
    final device = fbp.BluetoothDevice.fromId(deviceId);
    if (device.isDisconnected) {
      return Future.value();
    }
    return device.disconnect(queue: false);
  }

  void _emitParsedReadings(
    StreamController<List<BluetoothMeasurementReading>> controller,
    fbp.BluetoothDevice device,
    List<int> bytes,
  ) {
    if (controller.isClosed || bytes.isEmpty) {
      return;
    }

    final readings = _parser.parseBytes(
      bytes,
      deviceName: _resolvedDeviceName(device),
    );
    if (readings.isNotEmpty) {
      controller.add(readings);
    }
  }

  String _deviceName(fbp.ScanResult result) {
    final advName = result.advertisementData.advName.trim();
    if (advName.isNotEmpty) {
      return advName;
    }
    return _resolvedDeviceName(result.device);
  }

  String _resolvedDeviceName(fbp.BluetoothDevice device) {
    final platformName = device.platformName.trim();
    if (platformName.isNotEmpty) {
      return platformName;
    }
    final advName = device.advName.trim();
    if (advName.isNotEmpty) {
      return advName;
    }
    return 'BLE ${device.remoteId.str}';
  }
}
