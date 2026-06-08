import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_spacing.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/error_state.dart';
import '../../../core/widgets/loading_skeleton.dart';
import '../../../data/db/app_database.dart';
import '../../../data/db/database_providers.dart';
import '../../work_orders/application/work_order_providers.dart';

final profileDataProvider = FutureProvider.autoDispose<ProfileData?>((
  ref,
) async {
  final database = await ref.watch(databaseReadyProvider.future);
  final tenantId = ref.watch(activeTenantIdProvider);
  final userId = ref.watch(activeTechnicianUserIdProvider);
  final tenant = await (database.select(
    database.tenants,
  )..where((table) => table.id.equals(tenantId))).getSingleOrNull();
  final user = await (database.select(
    database.users,
  )..where((table) => table.id.equals(userId))).getSingleOrNull();
  if (tenant == null || user == null) {
    return null;
  }
  return ProfileData(tenant: tenant, user: user);
});

final class ProfileData {
  const ProfileData({required this.tenant, required this.user});

  final TenantRow tenant;
  final UserRow user;
}

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(profileDataProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Profil')),
      body: SafeArea(
        child: profile.when(
          loading: () => const LoadingSkeleton(itemCount: 3),
          error: (error, stackTrace) => ErrorState(
            title: 'Profil konnte nicht geladen werden',
            message: error.toString(),
            onRetry: () => ref.invalidate(profileDataProvider),
          ),
          data: (profile) {
            if (profile == null) {
              return const EmptyState(
                icon: Icons.person_off_outlined,
                title: 'Profil nicht verfügbar',
                message: 'Die lokalen Stammdaten fehlen.',
              );
            }

            return ListView(
              padding: const EdgeInsets.all(AppSpacing.lg),
              children: [
                _InfoCard(
                  title: '${profile.user.firstName} ${profile.user.lastName}',
                  rows: [
                    ('Rolle', profile.user.role),
                    ('E-Mail', profile.user.email),
                    ('Telefon', profile.user.phone ?? '-'),
                  ],
                ),
                const SizedBox(height: AppSpacing.md),
                _InfoCard(
                  title: profile.tenant.name,
                  rows: [
                    ('Adresse', profile.tenant.address),
                    (
                      'Ort',
                      '${profile.tenant.postalCode} ${profile.tenant.city}',
                    ),
                    ('Land', profile.tenant.country),
                    ('Telefon', profile.tenant.phone),
                    ('E-Mail', profile.tenant.email),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.title, required this.rows});

  final String title;
  final List<(String, String)> rows;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: AppSpacing.md),
            ...rows.map(
              (row) => Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 112,
                      child: Text(
                        row.$1,
                        style: const TextStyle(fontWeight: FontWeight.w800),
                      ),
                    ),
                    Expanded(child: Text(row.$2)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
