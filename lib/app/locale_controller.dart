import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleController extends ChangeNotifier {
  LocaleController(this._preferences)
    : _locale = _readLocale(_preferences.getString(_languageKey));

  static const _languageKey = 'language_code';
  final SharedPreferences _preferences;
  Locale? _locale;

  Locale? get locale => _locale;

  Future<void> setLocale(Locale? locale) async {
    if (_locale == locale) return;
    _locale = locale;
    notifyListeners();

    if (locale == null) {
      await _preferences.remove(_languageKey);
    } else {
      await _preferences.setString(_languageKey, locale.languageCode);
    }
  }

  static Locale? _readLocale(String? languageCode) {
    if (languageCode == null) return null;
    if (!const {'en', 'he', 'ru'}.contains(languageCode)) return null;
    return Locale(languageCode);
  }
}
