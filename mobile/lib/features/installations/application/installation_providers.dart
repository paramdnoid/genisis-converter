import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/db/database_providers.dart';
import '../../../data/repositories/drift_installation_repository.dart';
import '../../../domain/entities/installation.dart';
import '../../../domain/entities/installation_detail.dart';
import '../../../domain/repositories/installation_repository.dart';
import '../../work_orders/application/work_order_providers.dart';
import 'installation_scan_matcher.dart';

final installationRepositoryProvider = FutureProvider<InstallationRepository>((
  ref,
) async {
  final database = await ref.watch(databaseReadyProvider.future);
  final tenantId = ref.watch(activeTenantIdProvider);
  return DriftInstallationRepository(database: database, tenantId: tenantId);
});

final installationListProvider = StreamProvider.autoDispose
    .family<List<Installation>, String>((ref, query) async* {
      final repository = await ref.watch(installationRepositoryProvider.future);
      final normalized = query.trim().toLowerCase();

      await for (final installations in repository.watchAll()) {
        if (normalized.isEmpty) {
          yield installations;
          continue;
        }

        yield installations
            .where((installation) {
              final haystack = [
                installation.type,
                installation.manufacturer,
                installation.model,
                installation.serialNumber,
                installation.locationDescription,
                installation.fuelType,
              ].whereType<String>().join(' ').toLowerCase();
              return haystack.contains(normalized);
            })
            .toList(growable: false);
      }
    });

final installationDetailProvider = FutureProvider.autoDispose
    .family<InstallationDetail?, String>((ref, installationId) async {
      final repository = await ref.watch(installationRepositoryProvider.future);
      return repository.getDetail(installationId);
    });

final installationScanMatchProvider = FutureProvider.autoDispose
    .family<InstallationScanMatch?, String>((ref, rawCode) async {
      final repository = await ref.watch(installationRepositoryProvider.future);
      final installations = await repository.watchAll().first;
      return const InstallationScanMatcher().match(
        rawCode: rawCode,
        installations: installations,
      );
    });
