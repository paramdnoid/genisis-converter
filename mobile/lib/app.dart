import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'core/routing/app_router.dart';
import 'core/theme/app_theme.dart';

class KaminfegerApp extends StatelessWidget {
  const KaminfegerApp({super.key, this.routerConfig});

  final GoRouter? routerConfig;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Kaminfeger Techniker',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      routerConfig: routerConfig ?? appRouter,
    );
  }
}
