import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:shared_preferences/shared_preferences.dart';

final appLocaleController = AppLocaleController();

final appLocaleProvider = ChangeNotifierProvider<AppLocaleController>((ref) {
  unawaited(appLocaleController.restore());
  return appLocaleController;
}, disposeNotifier: false);

final class AppLocaleController extends ChangeNotifier {
  static const _preferenceKey = 'app_locale_code';
  static const supportedLanguageCodes = {'de', 'fr', 'it'};

  Locale? _locale;
  bool _isLoaded = false;

  Locale? get locale => _locale;
  String? get localeCode => _locale?.languageCode;
  bool get isLoaded => _isLoaded;

  Future<void> restore() async {
    final preferences = await SharedPreferences.getInstance();
    final code = preferences.getString(_preferenceKey);
    _locale = _localeFromCode(code);
    _isLoaded = true;
    notifyListeners();
  }

  Future<void> setLocaleCode(String? code) async {
    final locale = _localeFromCode(code);
    final preferences = await SharedPreferences.getInstance();
    if (locale == null) {
      await preferences.remove(_preferenceKey);
    } else {
      await preferences.setString(_preferenceKey, locale.languageCode);
    }
    _locale = locale;
    _isLoaded = true;
    notifyListeners();
  }

  Locale? _localeFromCode(String? code) {
    final normalized = code?.trim().toLowerCase();
    if (normalized == null || normalized.isEmpty || normalized == 'system') {
      return null;
    }
    if (!supportedLanguageCodes.contains(normalized)) {
      return null;
    }
    return Locale(normalized);
  }
}
