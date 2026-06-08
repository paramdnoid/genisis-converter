import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:path_provider/path_provider.dart';

import '../../../core/constants/app_spacing.dart';
import '../../../core/files/file_storage_service.dart';
import '../../../core/routing/app_router.dart';
import '../../../data/db/database_providers.dart';
import '../../../features/auth/application/auth_providers.dart';
import '../../work_orders/application/work_order_providers.dart';

final storageUsageProvider = FutureProvider.autoDispose<int>((ref) {
  return const FileStorageService().storageUsageBytes();
});

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usage = ref.watch(storageUsageProvider);
    final session = ref.watch(authSessionProvider).session;

    return Scaffold(
      appBar: AppBar(title: const Text('Einstellungen')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.lg,
            AppSpacing.md,
            AppSpacing.lg,
            AppSpacing.xl,
          ),
          children: [
            _SettingsTile(
              icon: Icons.person_outline,
              title: 'Profil',
              value: session?.email ?? 'Demo-Techniker',
              onTap: () => context.push(AppRoutes.settingsProfile),
            ),
            _SettingsTile(
              icon: Icons.storage_outlined,
              title: 'Speicher',
              value: usage.maybeWhen(
                data: (bytes) =>
                    '${(bytes / 1024 / 1024).toStringAsFixed(1)} MB',
                orElse: () => 'wird berechnet',
              ),
            ),
            _SettingsTile(
              icon: Icons.info_outline,
              title: 'App-Version',
              value: '1.0.0+1',
            ),
            const SizedBox(height: AppSpacing.lg),
            FilledButton.icon(
              onPressed: () => context.push(AppRoutes.syncStatus),
              icon: const Icon(Icons.sync),
              label: const Text('Sync-Status öffnen'),
            ),
            const SizedBox(height: AppSpacing.md),
            OutlinedButton.icon(
              onPressed: () => _exportDebug(context, ref),
              icon: const Icon(Icons.ios_share_outlined),
              label: const Text('Debug Export erstellen'),
            ),
            const SizedBox(height: AppSpacing.md),
            OutlinedButton.icon(
              onPressed: () async {
                final repository = ref.read(authRepositoryProvider);
                await ref.read(authSessionProvider).logout(repository);
                if (context.mounted) {
                  context.go(AppRoutes.login);
                }
              },
              icon: const Icon(Icons.logout),
              label: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _exportDebug(BuildContext context, WidgetRef ref) async {
    final database = await ref.read(databaseReadyProvider.future);
    final tenantId = ref.read(activeTenantIdProvider);
    final root = await getApplicationDocumentsDirectory();
    final outbox = await database.outboxDao.watchPending(tenantId).first;
    final orders = await database.workOrderDao.watchActive(tenantId).first;
    final payload = {
      'created_at': DateTime.now().toUtc().toIso8601String(),
      'tenant_id': tenantId,
      'work_orders': orders.length,
      'pending_sync_entries': outbox.length,
      'pending_entries': outbox
          .map(
            (entry) => {
              'id': entry.id,
              'entity_type': entry.entityType,
              'entity_id': entry.entityId,
              'operation': entry.operation,
              'status': entry.status,
              'attempts': entry.attempts,
              'error_message': entry.errorMessage,
            },
          )
          .toList(growable: false),
    };
    final file = File('${root.path}/debug-export.json');
    await file.writeAsString(
      const JsonEncoder.withIndent('  ').convert(payload),
      flush: true,
    );
    if (context.mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Debug Export: ${file.path}')));
    }
  }
}

class _SettingsTile extends StatelessWidget {
  const _SettingsTile({
    required this.icon,
    required this.title,
    required this.value,
    this.onTap,
  });

  final IconData icon;
  final String title;
  final String value;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Row(
            children: [
              Icon(icon),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(fontWeight: FontWeight.w800),
                    ),
                    Text(value),
                  ],
                ),
              ),
              if (onTap != null) const Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }
}
