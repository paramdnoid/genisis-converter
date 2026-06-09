import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_spacing.dart';
import '../../../core/routing/app_router.dart';
import '../../../data/db/database_providers.dart';
import '../../../data/sync/sync_providers.dart';
import '../../../l10n/app_localizations_x.dart';

class InitialSyncScreen extends ConsumerStatefulWidget {
  const InitialSyncScreen({super.key});

  @override
  ConsumerState<InitialSyncScreen> createState() => _InitialSyncScreenState();
}

class _InitialSyncScreenState extends ConsumerState<InitialSyncScreen> {
  var _progress = 0.0;
  String? _label;
  bool _running = false;
  String? _error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.initialSyncTitle)),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),
              Icon(
                Icons.cloud_sync_outlined,
                size: 64,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: AppSpacing.xl),
              Text(
                context.l10n.initialSyncLoadTitle,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(_label ?? context.l10n.initialSyncReadyLabel),
              if (_error != null) ...[
                const SizedBox(height: AppSpacing.md),
                Text(
                  _error!,
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
              ],
              const SizedBox(height: AppSpacing.lg),
              LinearProgressIndicator(value: _progress),
              const Spacer(),
              FilledButton.icon(
                onPressed: _running ? null : _run,
                icon: Icon(_error == null ? Icons.sync : Icons.refresh),
                label: Text(
                  _error == null
                      ? context.l10n.initialSyncLoadMinimalAction
                      : context.l10n.retryAction,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _run() async {
    final l10n = context.l10n;
    final steps = [
      l10n.initialSyncProfileStep,
      l10n.initialSyncOrdersStep,
      l10n.initialSyncObjectsStep,
      l10n.initialSyncChecklistStep,
    ];

    setState(() {
      _running = true;
      _progress = 0.15;
      _label = l10n.initialSyncOpenDatabaseStep;
      _error = null;
    });

    try {
      ref.invalidate(databaseReadyProvider);
      await ref.read(databaseReadyProvider.future);
      ref.invalidate(syncNowProvider);

      for (var i = 0; i < steps.length; i += 1) {
        if (i == 1) {
          _startBestEffortSync();
        }
        await Future<void>.delayed(const Duration(milliseconds: 180));
        if (!mounted) {
          return;
        }
        setState(() {
          _label = steps[i];
          _progress = (i + 2) / (steps.length + 2);
        });
      }

      if (mounted) {
        context.go(AppRoutes.dashboard);
      }
    } catch (error) {
      if (!mounted) {
        return;
      }
      setState(() {
        _label = l10n.initialSyncFailedLabel;
        _error = error.toString();
        _running = false;
      });
    }
  }

  void _startBestEffortSync() {
    unawaited(
      ref.read(syncNowProvider.future).then<void>((_) {}).catchError((_) {}),
    );
  }
}
