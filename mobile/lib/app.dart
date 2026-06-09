import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'core/routing/app_router.dart';
import 'core/theme/app_theme.dart';
import 'data/sync/sync_providers.dart';
import 'features/auth/application/auth_providers.dart';
import 'features/work_orders/application/remote_push_providers.dart';
import 'l10n/app_locale_controller.dart';
import 'l10n/app_localizations_x.dart';

class KaminfegerApp extends ConsumerWidget {
  const KaminfegerApp({super.key, this.routerConfig});

  final GoRouter? routerConfig;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref.watch(authSessionProvider).session;
    if (session != null) {
      ref.watch(syncBootstrapProvider);
      ref.watch(remotePushBootstrapProvider);
    }
    final appLocale = ref.watch(appLocaleProvider);

    return MaterialApp.router(
      onGenerateTitle: (context) => context.l10n.appTitle,
      debugShowCheckedModeBanner: false,
      locale: appLocale.locale,
      localizationsDelegates: AppLocalizationDefaults.localizationsDelegates,
      supportedLocales: AppLocalizationDefaults.supportedLocales,
      theme: AppTheme.light,
      routerConfig: routerConfig ?? appRouter,
    );
  }
}
