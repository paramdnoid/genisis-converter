import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_spacing.dart';
import '../../../core/routing/app_router.dart';
import '../../../data/db/database_providers.dart';

class InitialSyncScreen extends ConsumerStatefulWidget {
  const InitialSyncScreen({super.key});

  @override
  ConsumerState<InitialSyncScreen> createState() => _InitialSyncScreenState();
}

class _InitialSyncScreenState extends ConsumerState<InitialSyncScreen> {
  var _progress = 0.0;
  String _label = 'Bereit';
  bool _running = false;
  String? _error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Initialer Sync')),
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
                'Arbeitsdaten laden',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(_label),
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
                  _error == null ? 'Minimaldaten laden' : 'Erneut versuchen',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _run() async {
    setState(() {
      _running = true;
      _progress = 0.15;
      _label = 'Lokale Datenbank öffnen';
      _error = null;
    });

    try {
      await ref.read(databaseReadyProvider.future);

      final steps = const [
        'Benutzerprofil prüfen',
        'Aufträge und Kunden bereitstellen',
        'Objekte und Anlagen bereitstellen',
        'Checklisten und Materialstamm bereitstellen',
      ];

      for (var i = 0; i < steps.length; i += 1) {
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
        _label = 'Initialer Sync fehlgeschlagen';
        _error = error.toString();
        _running = false;
      });
    }
  }
}
