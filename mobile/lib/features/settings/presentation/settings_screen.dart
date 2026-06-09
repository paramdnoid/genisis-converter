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
import '../../../l10n/app_locale_controller.dart';
import '../../../l10n/app_localizations_x.dart';
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
      appBar: AppBar(title: Text(context.l10n.settingsTitle)),
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
              title: context.l10n.profileTitle,
              value: session?.email ?? context.l10n.demoTechnician,
              onTap: () => context.push(AppRoutes.settingsProfile),
            ),
            const _LanguageSelector(),
            _SettingsTile(
              icon: Icons.storage_outlined,
              title: context.l10n.storageTitle,
              value: usage.maybeWhen(
                data: (bytes) =>
                    '${context.formatDecimal(bytes / 1024 / 1024)} MB',
                orElse: () => context.l10n.calculatingStatus,
              ),
            ),
            _SettingsTile(
              icon: Icons.info_outline,
              title: context.l10n.appVersionTitle,
              value: '1.0.0+1',
            ),
            const SizedBox(height: AppSpacing.lg),
            FilledButton.icon(
              onPressed: () => context.push(AppRoutes.syncStatus),
              icon: const Icon(Icons.sync),
              label: Text(context.l10n.openSyncStatusAction),
            ),
            const SizedBox(height: AppSpacing.md),
            OutlinedButton.icon(
              onPressed: () => _exportDebug(context, ref),
              icon: const Icon(Icons.ios_share_outlined),
              label: Text(context.l10n.createDebugExportAction),
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
              label: Text(context.l10n.logoutAction),
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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.l10n.debugExportMessage(file.path))),
      );
    }
  }
}

class _LanguageSelector extends ConsumerWidget {
  const _LanguageSelector();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(appLocaleProvider);
    final selectedCode = controller.localeCode ?? 'system';
    final options = [
      ('system', context.l10n.languageSystemOption),
      ('de', context.l10n.languageGermanOption),
      ('fr', context.l10n.languageFrenchOption),
      ('it', context.l10n.languageItalianOption),
    ];

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.language_outlined),
                const SizedBox(width: AppSpacing.md),
                Text(
                  context.l10n.languageTitle,
                  style: const TextStyle(fontWeight: FontWeight.w800),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.sm,
              children: [
                for (final option in options)
                  ChoiceChip(
                    label: Text(option.$2),
                    selected: selectedCode == option.$1,
                    onSelected: (_) => ref
                        .read(appLocaleProvider)
                        .setLocaleCode(
                          option.$1 == 'system' ? null : option.$1,
                        ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
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
