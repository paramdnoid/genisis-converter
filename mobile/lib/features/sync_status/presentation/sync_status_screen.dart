import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_spacing.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/error_state.dart';
import '../../../core/widgets/loading_skeleton.dart';
import '../../../core/widgets/status_badge.dart';
import '../../../data/db/app_database.dart';
import '../../../data/db/database_providers.dart';
import '../../../data/sync/sync_providers.dart';
import '../../work_orders/application/work_order_providers.dart';

final pendingOutboxEntriesProvider = StreamProvider.autoDispose
    .family<List<OutboxEntryRow>, String>((ref, tenantId) async* {
      final database = await ref.watch(databaseReadyProvider.future);
      yield* database.outboxDao.watchPending(tenantId);
    });

class SyncStatusScreen extends ConsumerWidget {
  const SyncStatusScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tenantId = ref.watch(activeTenantIdProvider);
    final entries = ref.watch(pendingOutboxEntriesProvider(tenantId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sync-Status'),
        actions: [
          IconButton(
            tooltip: 'Jetzt synchronisieren',
            onPressed: () => ref.invalidate(syncNowProvider),
            icon: const Icon(Icons.sync),
          ),
        ],
      ),
      body: SafeArea(
        child: entries.when(
          loading: () => const LoadingSkeleton(itemCount: 4),
          error: (error, stackTrace) => ErrorState(
            title: 'Sync-Status konnte nicht geladen werden',
            message: error.toString(),
            onRetry: () =>
                ref.invalidate(pendingOutboxEntriesProvider(tenantId)),
          ),
          data: (entries) => ListView(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.lg,
              AppSpacing.md,
              AppSpacing.lg,
              AppSpacing.xl,
            ),
            children: [
              if (entries.isEmpty)
                const EmptyState(
                  icon: Icons.cloud_done_outlined,
                  title: 'Keine offenen Sync-Einträge',
                  message: 'Lokale Änderungen sind abgearbeitet.',
                )
              else
                ...entries.map(
                  (entry) => Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.md),
                    child: _OutboxCard(entry: entry),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OutboxCard extends StatelessWidget {
  const _OutboxCard({required this.entry});

  final OutboxEntryRow entry;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${entry.entityType} · ${entry.operation}',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(entry.entityId),
                  if (entry.errorMessage != null) Text(entry.errorMessage!),
                ],
              ),
            ),
            StatusBadge(
              label: entry.status,
              icon: Icons.cloud_upload_outlined,
              tone: entry.status == 'failed'
                  ? StatusBadgeTone.error
                  : StatusBadgeTone.warning,
            ),
          ],
        ),
      ),
    );
  }
}
