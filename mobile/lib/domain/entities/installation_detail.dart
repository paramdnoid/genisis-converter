import 'installation.dart';
import 'photo_attachment.dart';
import 'work_order.dart';

final class InstallationDetail {
  const InstallationDetail({
    required this.installation,
    required this.history,
    required this.photos,
  });

  final Installation installation;
  final List<WorkOrder> history;
  final List<PhotoAttachment> photos;
}
