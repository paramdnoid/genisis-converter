import 'package:flutter/material.dart';
import 'package:kaminfeger_mobile/core/theme/app_theme.dart';
import 'package:kaminfeger_mobile/l10n/app_localizations_x.dart';

MaterialApp localizedTestApp({required Widget home}) {
  return MaterialApp(
    theme: AppTheme.light,
    localizationsDelegates: AppLocalizationDefaults.localizationsDelegates,
    supportedLocales: AppLocalizationDefaults.supportedLocales,
    home: home,
  );
}

MaterialApp localizedRouterTestApp({required RouterConfig<Object> router}) {
  return MaterialApp.router(
    theme: AppTheme.light,
    localizationsDelegates: AppLocalizationDefaults.localizationsDelegates,
    supportedLocales: AppLocalizationDefaults.supportedLocales,
    routerConfig: router,
  );
}
