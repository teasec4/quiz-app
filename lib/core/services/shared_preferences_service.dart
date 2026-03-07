import 'package:shared_preferences/shared_preferences.dart';

/// Service for managing user preferences using SharedPreferences
class SharedPreferencesService {
  static const String _themeVariantKey = 'theme_variant';
  static const String _darkModeKey = 'dark_mode';
  static const String _localeKey = 'locale';

  final SharedPreferences _prefs;

  SharedPreferencesService(this._prefs);

  /// Save theme variant preference
  /// Returns true if successful
  Future<bool> saveThemeVariant(String variant) async {
    return await _prefs.setString(_themeVariantKey, variant);
  }

  /// Get saved theme variant
  /// Returns null if not set
  String? getThemeVariant() {
    return _prefs.getString(_themeVariantKey);
  }

  /// Save dark mode preference
  /// Returns true if successful
  Future<bool> saveDarkMode(bool isDark) async {
    return await _prefs.setBool(_darkModeKey, isDark);
  }

  /// Get dark mode preference
  /// Returns false by default if not set
  bool getDarkMode() {
    return _prefs.getBool(_darkModeKey) ?? false;
  }

  /// Save locale preference
  /// Returns true if successful
  Future<bool> saveLocale(String languageCode) async {
    return await _prefs.setString(_localeKey, languageCode);
  }

  /// Get saved locale
  /// Returns null if not set
  String? getLocale() {
    return _prefs.getString(_localeKey);
  }

  /// Clear all preferences
  Future<bool> clearAll() async {
    return await _prefs.clear();
  }
}
