import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/db/database_providers.dart';
import '../../../data/repositories/drift_measurement_repository.dart';
import '../../../domain/entities/measurement.dart';
import '../../../domain/repositories/measurement_repository.dart';
import '../../../domain/use_cases/save_measurement.dart';
import '../../../domain/use_cases/validate_measurement.dart';
import '../../work_orders/application/work_order_providers.dart';
import 'bluetooth_measurement.dart';
import 'flutter_blue_plus_measurement_client.dart';

final measurementRepositoryProvider = FutureProvider<MeasurementRepository>((
  ref,
) async {
  final database = await ref.watch(databaseReadyProvider.future);
  final tenantId = ref.watch(activeTenantIdProvider);
  return DriftMeasurementRepository(database: database, tenantId: tenantId);
});

final measurementsForWorkOrderProvider = StreamProvider.autoDispose
    .family<List<Measurement>, String>((ref, workOrderId) async* {
      final repository = await ref.watch(measurementRepositoryProvider.future);
      yield* repository.watchForWorkOrder(workOrderId);
    });

final validateMeasurementProvider = Provider<ValidateMeasurement>((ref) {
  return const ValidateMeasurement();
});

final saveMeasurementProvider = FutureProvider<SaveMeasurement>((ref) async {
  final repository = await ref.watch(measurementRepositoryProvider.future);
  return SaveMeasurement(repository);
});

final bluetoothMeasurementClientProvider = Provider<BluetoothMeasurementClient>(
  (ref) {
    return FlutterBluePlusMeasurementClient();
  },
);

final bluetoothMeasurementDevicesProvider =
    StreamProvider.autoDispose<List<BluetoothMeasurementDevice>>((ref) {
      final client = ref.watch(bluetoothMeasurementClientProvider);
      return client.watchDevices();
    });

final bluetoothMeasurementScanningProvider = StreamProvider.autoDispose<bool>((
  ref,
) {
  final client = ref.watch(bluetoothMeasurementClientProvider);
  return client.watchScanning();
});
