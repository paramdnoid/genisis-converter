import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:kaminfeger_mobile/core/errors/app_error.dart';
import 'package:kaminfeger_mobile/core/files/file_storage_service.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

void main() {
  late Directory root;
  late FileStorageService service;

  setUp(() async {
    root = await Directory.systemTemp.createTemp('file_storage_service_test_');
    PathProviderPlatform.instance = _FakePathProviderPlatform(root.path);
    service = const FileStorageService();
  });

  tearDown(() async {
    if (await root.exists()) {
      await root.delete(recursive: true);
    }
  });

  test('writes bytes into the expected work-order file path', () async {
    final stored = await service.writeBytesIntoWorkOrder(
      tenantId: 'tenant-1',
      workOrderId: 'work-order-1',
      bytes: Uint8List.fromList([1, 2, 3, 4]),
      fileName: 'photo.jpg',
      mimeType: 'image/jpeg',
    );

    final expectedPath = path.join(
      root.path,
      'files',
      'tenant-1',
      'work-order-1',
      'photo.jpg',
    );

    expect(stored.path, expectedPath);
    expect(stored.fileName, 'photo.jpg');
    expect(stored.mimeType, 'image/jpeg');
    expect(stored.sizeBytes, 4);
    expect(await File(expectedPath).readAsBytes(), [1, 2, 3, 4]);
  });

  test('copies a source file into work-order storage', () async {
    final source = File(path.join(root.path, 'source.txt'));
    await source.writeAsString('rapport file');

    final stored = await service.copyIntoWorkOrder(
      tenantId: 'tenant-1',
      workOrderId: 'work-order-2',
      source: source,
      fileName: 'copy.txt',
      mimeType: 'text/plain',
    );

    expect(stored.sizeBytes, 'rapport file'.length);
    expect(await File(stored.path).readAsString(), 'rapport file');
    expect(
      stored.path,
      contains(path.join('files', 'tenant-1', 'work-order-2')),
    );
  });

  test('calculates recursive storage usage', () async {
    await service.writeBytesIntoWorkOrder(
      tenantId: 'tenant-1',
      workOrderId: 'work-order-1',
      bytes: Uint8List.fromList([1, 2, 3]),
      fileName: 'a.bin',
      mimeType: 'application/octet-stream',
    );
    await service.writeBytesIntoWorkOrder(
      tenantId: 'tenant-1',
      workOrderId: 'work-order-2',
      bytes: Uint8List.fromList([4, 5]),
      fileName: 'b.bin',
      mimeType: 'application/octet-stream',
    );

    expect(await service.storageUsageBytes(), 5);
  });

  test('wraps file operation failures in FileStorageError', () async {
    await expectLater(
      service.copyIntoWorkOrder(
        tenantId: 'tenant-1',
        workOrderId: 'work-order-1',
        source: File(path.join(root.path, 'missing.jpg')),
        fileName: 'missing.jpg',
        mimeType: 'image/jpeg',
      ),
      throwsA(isA<FileStorageError>()),
    );
  });
}

final class _FakePathProviderPlatform extends PathProviderPlatform
    with MockPlatformInterfaceMixin {
  _FakePathProviderPlatform(this.documentsPath);

  final String documentsPath;

  @override
  Future<String?> getApplicationDocumentsPath() async => documentsPath;
}
