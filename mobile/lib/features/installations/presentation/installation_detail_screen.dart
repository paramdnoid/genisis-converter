import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_spacing.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/error_state.dart';
import '../../../core/widgets/loading_skeleton.dart';
import '../../../data/db/app_database.dart';
import '../../../data/db/database_providers.dart';

final installationDetailProvider = FutureProvider.autoDispose
    .family<InstallationRow?, String>((ref, installationId) async {
      final database = await ref.watch(databaseReadyProvider.future);
      return (database.select(
        database.installations,
      )..where((table) => table.id.equals(installationId))).getSingleOrNull();
    });

class InstallationDetailScreen extends ConsumerWidget {
  const InstallationDetailScreen({required this.installationId, super.key});

  final String installationId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final installation = ref.watch(installationDetailProvider(installationId));

    return Scaffold(
      appBar: AppBar(title: const Text('Anlage')),
      body: SafeArea(
        child: installation.when(
          loading: () => const LoadingSkeleton(itemCount: 3),
          error: (error, stackTrace) => ErrorState(
            title: 'Anlage konnte nicht geladen werden',
            message: error.toString(),
          ),
          data: (installation) {
            if (installation == null) {
              return const EmptyState(
                icon: Icons.fireplace_outlined,
                title: 'Anlage nicht gefunden',
                message: 'Der lokale Datensatz ist nicht vorhanden.',
              );
            }
            return ListView(
              padding: const EdgeInsets.all(AppSpacing.lg),
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          [
                            installation.manufacturer,
                            installation.model,
                          ].whereType<String>().join(' '),
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.w800),
                        ),
                        const SizedBox(height: AppSpacing.md),
                        Text('Typ: ${installation.type}'),
                        Text('Brennstoff: ${installation.fuelType ?? '-'}'),
                        Text(
                          'Standort: ${installation.locationDescription ?? '-'}',
                        ),
                        Text(
                          'Seriennummer: ${installation.serialNumber ?? '-'}',
                        ),
                        if (installation.notes != null) ...[
                          const SizedBox(height: AppSpacing.sm),
                          Text('Notizen: ${installation.notes!}'),
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
