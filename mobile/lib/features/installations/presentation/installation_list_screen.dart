import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_spacing.dart';
import '../../../core/routing/app_router.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/error_state.dart';
import '../../../core/widgets/loading_skeleton.dart';
import '../../../domain/entities/installation.dart';
import '../../../l10n/app_localizations_x.dart';
import '../application/installation_providers.dart';

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
      appBar: AppBar(
        title: Text(context.l10n.installationsTitle),
        actions: [
          IconButton(
            tooltip: context.l10n.installationScanTooltip,
            onPressed: () => context.push(AppRoutes.installationScan),
            icon: const Icon(Icons.qr_code_scanner_outlined),
          ),
        ],
      ),
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
              decoration: InputDecoration(
                labelText: context.l10n.installationListSearchLabel,
                prefixIcon: const Icon(Icons.search),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            installations.when(
              loading: () => const LoadingSkeleton(itemCount: 5),
              error: (error, stackTrace) => ErrorState(
                title: context.l10n.installationsLoadErrorTitle,
                message: error.toString(),
              ),
              data: (items) {
                if (items.isEmpty) {
                  return EmptyState(
                    icon: Icons.fireplace_outlined,
                    title: context.l10n.installationsEmptyTitle,
                    message: context.l10n.installationsEmptyMessage,
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

String _installationTitle(Installation installation) {
  return installation.displayName;
}
