final class PhotoAttachment {
  const PhotoAttachment({
    required this.id,
    required this.tenantId,
    required this.localPath,
    required this.fileName,
    required this.mimeType,
    required this.sizeBytes,
    required this.takenAt,
    required this.uploadStatus,
    required this.version,
    required this.syncStatus,
    this.workOrderId,
    this.objectId,
    this.installationId,
    this.defectId,
    this.remoteUrl,
    this.caption,
  });

  final String id;
  final String tenantId;
  final String localPath;
  final String fileName;
  final String mimeType;
  final int sizeBytes;
  final DateTime takenAt;
  final String uploadStatus;
  final int version;
  final String syncStatus;
  final String? workOrderId;
  final String? objectId;
  final String? installationId;
  final String? defectId;
  final String? remoteUrl;
  final String? caption;

  bool get isPendingUpload => uploadStatus != 'uploaded';
  bool get isDirty => syncStatus != 'synced';
}

final class PhotoDraft {
  const PhotoDraft({
    required this.localPath,
    required this.fileName,
    required this.mimeType,
    required this.sizeBytes,
    this.workOrderId,
    this.objectId,
    this.installationId,
    this.defectId,
    this.caption,
  });

  final String localPath;
  final String fileName;
  final String mimeType;
  final int sizeBytes;
  final String? workOrderId;
  final String? objectId;
  final String? installationId;
  final String? defectId;
  final String? caption;
}
