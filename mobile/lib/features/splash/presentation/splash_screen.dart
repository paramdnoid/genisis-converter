import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_spacing.dart';
import '../../../core/routing/app_router.dart';
import '../../../l10n/app_localizations_x.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),
              Align(
                alignment: Alignment.centerLeft,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    child: Icon(
                      Icons.fireplace_outlined,
                      size: 40,
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
              Text(
                'Kaminfeger Techniker',
                style: textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                context.l10n.splashTagline,
                style: textTheme.bodyLarge?.copyWith(height: 1.45),
              ),
              const SizedBox(height: AppSpacing.xl),
              const _ReadinessRow(),
              const Spacer(),
              FilledButton.icon(
                onPressed: () => context.go(AppRoutes.login),
                icon: const Icon(Icons.login),
                label: Text(context.l10n.goToLoginAction),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ReadinessRow extends StatelessWidget {
  const _ReadinessRow();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: AppSpacing.sm,
      runSpacing: AppSpacing.sm,
      children: const [
        _ReadinessChip(icon: Icons.wifi_off, label: 'Offline bereit'),
        _ReadinessChip(icon: Icons.sync, label: 'Sync vorbereitet'),
        _ReadinessChip(icon: Icons.assignment, label: 'Rapportfähig'),
      ],
    );
  }
}

class _ReadinessChip extends StatelessWidget {
  const _ReadinessChip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Chip(
      avatar: Icon(icon, size: 18),
      label: Text(label),
      side: BorderSide(color: Theme.of(context).colorScheme.outlineVariant),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    );
  }
}
