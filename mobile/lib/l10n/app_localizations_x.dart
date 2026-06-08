import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';

import 'generated/app_localizations.dart';

extension AppLocalizationsX on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);

  String formatShortTime(DateTime value) {
    return DateFormat.Hm(l10n.localeName).format(value.toLocal());
  }

  String formatShortDate(DateTime value) {
    return DateFormat.yMd(l10n.localeName).format(value.toLocal());
  }

  String formatShortDateTime(DateTime value) {
    return DateFormat.yMd(l10n.localeName).add_Hm().format(value.toLocal());
  }

  String formatDecimal(num value, {int decimalDigits = 1}) {
    return NumberFormat.decimalPatternDigits(
      locale: l10n.localeName,
      decimalDigits: decimalDigits,
    ).format(value);
  }
}

abstract final class AppLocalizationDefaults {
  static const supportedLocales = AppLocalizations.supportedLocales;

  static const localizationsDelegates = [
    AppLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];
}
