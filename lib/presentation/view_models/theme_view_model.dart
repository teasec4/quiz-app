import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bookexample/presentation/view_models/base_view_model.dart';
import 'package:bookexample/core/theme/app_theme.dart';
import 'package:bookexample/core/logging/logger.dart';
import 'package:bookexample/core/theme/theme_storage.dart';

class ThemeViewModel extends BaseViewModel {
  static const String _darkModeKey = 'dark_mode';

  bool _isDarkMode = false;

  ThemeData? _cachedThemeData;

  SharedPreferences? _prefs;

  bool get isDarkMode => _isDarkMode;

  ThemeData get currentTheme {
    if (_cachedThemeData == null) {
      _cachedThemeData = AppThemeFactory.getTheme(darkMode: _isDarkMode);
    }
    return _cachedThemeData!;
  }

  ColorScheme get currentColorScheme =>
      AppThemeFactory.getColorScheme(darkMode: _isDarkMode);

  Future<void> initialize() async {
    await executeAsync(() async {
      try {
        _prefs = await SharedPreferences.getInstance();
        final savedDarkMode = _prefs?.getBool(_darkModeKey);

        if (savedDarkMode != null) {
          _isDarkMode = savedDarkMode;
        }
      } catch (e) {
        AppLogger.warning('Failed to load from shared_preferences: $e');
      }

      _cachedThemeData = AppThemeFactory.getTheme(darkMode: _isDarkMode);
    }, operationName: 'initializeTheme');
  }

  Future<void> setDarkMode(bool enabled) async {
    await executeAsync(() async {
      if (_isDarkMode != enabled) {
        _isDarkMode = enabled;
        _cachedThemeData = null;

        try {
          await _prefs?.setBool(_darkModeKey, _isDarkMode);
        } catch (e) {
          AppLogger.warning('Failed to save dark mode: $e');
        }
        notifyListeners();
      }
    }, operationName: 'setDarkMode');
  }

  Future<void> resetToDefaults() async {
    await executeAsync(() async {
      _isDarkMode = false;
      _cachedThemeData = null;

      try {
        await _prefs?.remove(_darkModeKey);
      } catch (e) {
        AppLogger.warning('Failed to clear dark mode: $e');
      }

      notifyListeners();
    }, operationName: 'resetTheme');
  }

  Map<String, dynamic> getCurrentSettings() {
    return {'darkMode': _isDarkMode, 'isDarkMode': _isDarkMode};
  }
}
