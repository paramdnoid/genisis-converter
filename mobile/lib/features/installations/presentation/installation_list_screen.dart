import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_spacing.dart';
import '../../../core/routing/app_router.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/error_state.dart';
import '../../../core/widgets/loading_skeleton.dart';
import '../../../data/db/app_database.dart';
import '../../../data/db/database_providers.dart';
import '../../work_orders/application/work_order_providers.dart';

final installationListProvider = StreamProvider.autoDispose
    .family<List<InstallationRow>, String>((ref, query) async* {
      final database = await ref.watch(databaseReadyProvider.future);
      final tenantId = ref.watch(activeTenantIdProvider);
      final normalized = query.trim().toLowerCase();
      await for (final rows in database.installationDao.watchActive(tenantId)) {
        if (normalized.isEmpty) {
          yield rows;
          continue;
        }
        yield rows
            .where((row) {
              final haystack = [
                row.type,
                row.manufacturer,
                row.model,
                row.serialNumber,
                row.locationDescription,
                row.fuelType,
              ].whereType<String>().join(' ').toLowerCase();
              return haystack.contains(normalized);
            })
            .toList(growable: false);
      }
    });

class InstallationListScreen extends ConsumerStatefulWidget {
  const InstallationListScreen({super.key});

  @override
  ConsumerState<InstallationListScreen> createState() =>
      _InstallationListScreenState();
}

class _InstallationListScreenState
    extends ConsumerState<InstallationListScreen> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final installations = ref.watch(installationListProvider(_query));

    return Scaffold(
      appBar: AppBar(title: const Text('Anlagen')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.lg,
            AppSpacing.md,
            AppSpacing.lg,
            AppSpacing.xl,
          ),
          children: [
            TextField(
              onChanged: (value) => setState(() => _query = value),
              decoration: const InputDecoration(
                labelText: 'Anlage suchen',
                prefixIcon: Icon(Icons.search),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            installations.when(
              loading: () => const LoadingSkeleton(itemCount: 5),
              error: (error, stackTrace) => ErrorState(
                title: 'Anlagen konnten nicht geladen werden',
                message: error.toString(),
              ),
              data: (items) {
                if (items.isEmpty) {
                  return const EmptyState(
                    icon: Icons.fireplace_outlined,
                    title: 'Keine Anlagen',
                    message: 'Die Anlagen werden aus der lokalen DB geladen.',
                  );
                }
                return Column(
                  children: items
                      .map(
                        (installation) => Padding(
                          padding: const EdgeInsets.only(bottom: AppSpacing.md),
                          child: Card(
                            child: ListTile(
                              leading: const Icon(Icons.fireplace_outlined),
                              title: Text(_installationTitle(installation)),
                              subtitle: Text(
                                installation.locationDescription ??
                                    installation.type,
                              ),
                              trailing: const Icon(Icons.chevron_right),
                              onTap: () => context.push(
                                AppRoutes.installationDetailPath(
                                  installation.id,
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(growable: false),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

String _installationTitle(InstallationRow installation) {
  final title = [
    installation.manufacturer,
    installation.model,
  ].whereType<String>().where((part) => part.trim().isNotEmpty).join(' ');
  return title.isEmpty ? installation.type : title;
}
