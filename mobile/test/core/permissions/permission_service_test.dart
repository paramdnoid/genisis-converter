import 'package:flutter_test/flutter_test.dart';
import 'package:kaminfeger_mobile/core/errors/app_error.dart';
import 'package:kaminfeger_mobile/core/permissions/permission_service.dart';
import 'package:permission_handler_platform_interface/permission_handler_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

void main() {
  late PermissionHandlerPlatform previousPlatform;
  late _FakePermissionHandlerPlatform platform;
  late PermissionService service;

  setUp(() {
    previousPlatform = PermissionHandlerPlatform.instance;
    platform = _FakePermissionHandlerPlatform();
    PermissionHandlerPlatform.instance = platform;
    service = const PermissionService();
  });

  tearDown(() {
    PermissionHandlerPlatform.instance = previousPlatform;
  });

  test(
    'isGranted maps app permissions and accepts granted or limited',
    () async {
      platform.statuses.addAll({
        Permission.camera: PermissionStatus.granted,
        Permission.photos: PermissionStatus.limited,
        Permission.locationWhenInUse: PermissionStatus.denied,
        Permission.bluetoothScan: PermissionStatus.granted,
        Permission.bluetoothConnect: PermissionStatus.granted,
      });

      expect(await service.isGranted(AppPermission.camera), isTrue);
      expect(await service.isGranted(AppPermission.photos), isTrue);
      expect(await service.isGranted(AppPermission.location), isFalse);
      expect(await service.isGranted(AppPermission.bluetoothScan), isTrue);
      expect(await service.isGranted(AppPermission.bluetoothConnect), isTrue);
      expect(platform.checkedPermissions, [
        Permission.camera,
        Permission.photos,
        Permission.locationWhenInUse,
        Permission.bluetoothScan,
        Permission.bluetoothConnect,
      ]);
    },
  );

  test(
    'require requests mapped permission and accepts granted or limited',
    () async {
      platform.requestStatuses.addAll({
        Permission.camera: PermissionStatus.granted,
        Permission.photos: PermissionStatus.limited,
        Permission.bluetoothScan: PermissionStatus.granted,
        Permission.bluetoothConnect: PermissionStatus.granted,
      });

      await service.require(AppPermission.camera);
      await service.require(AppPermission.photos);
      await service.require(AppPermission.bluetoothScan);
      await service.require(AppPermission.bluetoothConnect);

      expect(platform.requestedPermissions, [
        [Permission.camera],
        [Permission.photos],
        [Permission.bluetoothScan],
        [Permission.bluetoothConnect],
      ]);
    },
  );

  test(
    'require throws PermissionError when requested permission is denied',
    () async {
      platform.requestStatuses[Permission.locationWhenInUse] =
          PermissionStatus.denied;

      await expectLater(
        service.require(AppPermission.location),
        throwsA(
          isA<PermissionError>()
              .having((error) => error.code, 'code', AppErrorCode.permission)
              .having(
                (error) => error.message,
                'message',
                contains('location'),
              ),
        ),
      );
      expect(platform.requestedPermissions, [
        [Permission.locationWhenInUse],
      ]);
    },
  );
}

final class _FakePermissionHandlerPlatform extends PermissionHandlerPlatform
    with MockPlatformInterfaceMixin {
  final statuses = <Permission, PermissionStatus>{};
  final requestStatuses = <Permission, PermissionStatus>{};
  final checkedPermissions = <Permission>[];
  final requestedPermissions = <List<Permission>>[];

  @override
  Future<PermissionStatus> checkPermissionStatus(Permission permission) async {
    checkedPermissions.add(permission);
    return statuses[permission] ?? PermissionStatus.denied;
  }

  @override
  Future<Map<Permission, PermissionStatus>> requestPermissions(
    List<Permission> permissions,
  ) async {
    requestedPermissions.add(List.unmodifiable(permissions));
    return {
      for (final permission in permissions)
        permission: requestStatuses[permission] ?? PermissionStatus.denied,
    };
  }
}
