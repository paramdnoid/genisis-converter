import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_spacing.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/error_state.dart';
import '../../../core/widgets/loading_skeleton.dart';
import '../../../data/db/app_database.dart';
import '../../../data/db/database_providers.dart';

final objectDetailProvider = FutureProvider.autoDispose
    .family<CustomerObjectRow?, String>((ref, objectId) async {
      final database = await ref.watch(databaseReadyProvider.future);
      return (database.select(
        database.customerObjects,
      )..where((table) => table.id.equals(objectId))).getSingleOrNull();
    });

class ObjectDetailScreen extends ConsumerWidget {
  const ObjectDetailScreen({required this.objectId, super.key});

  final String objectId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final object = ref.watch(objectDetailProvider(objectId));

    return Scaffold(
      appBar: AppBar(title: const Text('Objekt')),
      body: SafeArea(
        child: object.when(
          loading: () => const LoadingSkeleton(itemCount: 3),
          error: (error, stackTrace) => ErrorState(
            title: 'Objekt konnte nicht geladen werden',
            message: error.toString(),
          ),
          data: (object) {
            if (object == null) {
              return const EmptyState(
                icon: Icons.home_work_outlined,
                title: 'Objekt nicht gefunden',
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
                          object.name,
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.w800),
                        ),
                        const SizedBox(height: AppSpacing.md),
                        Text(
                          '${object.street} ${object.houseNumber}, '
                          '${object.postalCode} ${object.city}',
                        ),
                        if (object.accessNotes != null) ...[
                          const SizedBox(height: AppSpacing.sm),
                          Text('Zugang: ${object.accessNotes!}'),
                        ],
                        if (object.safetyNotes != null) ...[
                          const SizedBox(height: AppSpacing.sm),
                          Text('Sicherheit: ${object.safetyNotes!}'),
                        ],
                        if (object.objectNotes != null) ...[
                          const SizedBox(height: AppSpacing.sm),
                          Text('Notizen: ${object.objectNotes!}'),
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
