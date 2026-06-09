import 'package:permission_handler/permission_handler.dart';

import '../errors/app_error.dart';

enum AppPermission { camera, photos, location, bluetoothScan, bluetoothConnect }

final class PermissionService {
  const PermissionService();

  Future<void> require(AppPermission permission) async {
    final status = await _permission(permission).request();
    if (!status.isGranted && !status.isLimited) {
      throw PermissionError(message: 'Permission denied: ${permission.name}');
    }
  }

  Future<bool> isGranted(AppPermission permission) async {
    final status = await _permission(permission).status;
    return status.isGranted || status.isLimited;
  }

  Permission _permission(AppPermission permission) {
    return switch (permission) {
      AppPermission.camera => Permission.camera,
      AppPermission.photos => Permission.photos,
      AppPermission.location => Permission.locationWhenInUse,
      AppPermission.bluetoothScan => Permission.bluetoothScan,
      AppPermission.bluetoothConnect => Permission.bluetoothConnect,
    };
  }
}
