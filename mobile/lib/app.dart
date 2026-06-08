import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'core/routing/app_router.dart';
import 'core/theme/app_theme.dart';
import 'data/sync/sync_providers.dart';

class KaminfegerApp extends ConsumerWidget {
  const KaminfegerApp({super.key, this.routerConfig});

  final GoRouter? routerConfig;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(syncBootstrapProvider);

    return MaterialApp.router(
      title: 'Kaminfeger Techniker',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      routerConfig: routerConfig ?? appRouter,
    );
  }
}
