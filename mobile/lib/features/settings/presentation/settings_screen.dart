import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_spacing.dart';
import '../../../core/files/file_storage_service.dart';
import '../../../core/routing/app_router.dart';
import '../../../features/auth/application/auth_providers.dart';

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
}

class _SettingsTile extends StatelessWidget {
  const _SettingsTile({
    required this.icon,
    required this.title,
    required this.value,
  });

  final IconData icon;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Card(
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
          ],
        ),
      ),
    );
  }
}
