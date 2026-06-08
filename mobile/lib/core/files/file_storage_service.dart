import 'dart:io';
import 'dart:typed_data';

import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

import '../errors/app_error.dart';

final class StoredFile {
  const StoredFile({
    required this.path,
    required this.fileName,
    required this.mimeType,
    required this.sizeBytes,
  });

  final String path;
  final String fileName;
  final String mimeType;
  final int sizeBytes;
}

final class FileStorageService {
  const FileStorageService();

  Future<StoredFile> copyIntoWorkOrder({
    required String tenantId,
    required String workOrderId,
    required File source,
    required String fileName,
    required String mimeType,
  }) async {
    try {
      final directory = await _workOrderDirectory(tenantId, workOrderId);
      final target = File(path.join(directory.path, fileName));
      final copied = await source.copy(target.path);
      final size = await copied.length();
      return StoredFile(
        path: copied.path,
        fileName: fileName,
        mimeType: mimeType,
        sizeBytes: size,
      );
    } catch (error, stackTrace) {
      throw FileStorageError(cause: error, stackTrace: stackTrace);
    }
  }

  Future<StoredFile> writeBytesIntoWorkOrder({
    required String tenantId,
    required String workOrderId,
    required Uint8List bytes,
    required String fileName,
    required String mimeType,
  }) async {
    try {
      final directory = await _workOrderDirectory(tenantId, workOrderId);
      final target = File(path.join(directory.path, fileName));
      final written = await target.writeAsBytes(bytes, flush: true);
      return StoredFile(
        path: written.path,
        fileName: fileName,
        mimeType: mimeType,
        sizeBytes: bytes.length,
      );
    } catch (error, stackTrace) {
      throw FileStorageError(cause: error, stackTrace: stackTrace);
    }
  }

  Future<int> storageUsageBytes() async {
    final root = await getApplicationDocumentsDirectory();
    if (!await root.exists()) {
      return 0;
    }
    var total = 0;
    await for (final entity in root.list(recursive: true)) {
      if (entity is File) {
        total += await entity.length();
      }
    }
    return total;
  }

  Future<Directory> _workOrderDirectory(
    String tenantId,
    String workOrderId,
  ) async {
    final root = await getApplicationDocumentsDirectory();
    final directory = Directory(
      path.join(root.path, 'files', tenantId, workOrderId),
    );
    if (!await directory.exists()) {
      await directory.create(recursive: true);
    }
    return directory;
  }
}
