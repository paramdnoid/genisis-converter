import '../entities/installation.dart';
import '../entities/installation_detail.dart';

abstract interface class InstallationRepository {
  Stream<List<Installation>> watchAll();

  Future<Installation?> getById(String id);

  Future<InstallationDetail?> getDetail(String id);

  Future<void> updateNotes({required String id, String? notes});
}
