import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bookexample/core/view_models/base_view_model.dart';
import 'package:bookexample/core/theme/app_theme.dart';
import 'package:bookexample/core/logging/app_logger.dart';
import 'package:bookexample/core/theme/theme_storage.dart';

/// ViewModel for managing application theme settings.
/// Provides centralized theme management with persistence support.
class ThemeViewModel extends BaseViewModel {
  static const String _themeVariantKey = 'theme_variant';
  static const String _darkModeKey = 'dark_mode';

  /// Current theme variant
  AppThemeVariant _currentVariant = AppThemeVariant.minimal;

  /// Whether dark mode is enabled
  bool _isDarkMode = false;

  /// Theme data cache to avoid rebuilding on every access
  ThemeData? _cachedThemeData;

  /// SharedPreferences instance for persistence
  SharedPreferences? _prefs;

  /// Gets the current theme variant
  AppThemeVariant get currentVariant => _currentVariant;

  /// Gets whether dark mode is enabled
  bool get isDarkMode => _isDarkMode;

  /// Gets the current theme data
  ThemeData get currentTheme {
    if (_cachedThemeData == null) {
      _cachedThemeData = _buildThemeData();
    }
    return _cachedThemeData!;
  }

  /// Gets the current color scheme
  ColorScheme get currentColorScheme =>
      AppThemeFactory.getColorScheme(_currentVariant, darkMode: _isDarkMode);

  /// Initializes the theme view model with saved preferences
  Future<void> initialize() async {
    await executeAsync(() async {
      bool loadedFromSharedPrefs = false;

      try {
        _prefs = await SharedPreferences.getInstance();

        // Load saved theme preferences
        final savedVariantIndex = _prefs?.getInt(_themeVariantKey);
        final savedDarkMode = _prefs?.getBool(_darkModeKey);

        if (savedVariantIndex != null &&
            savedVariantIndex >= 0 &&
            savedVariantIndex < AppThemeVariant.values.length) {
          _currentVariant = AppThemeVariant.values[savedVariantIndex];
          loadedFromSharedPrefs = true;
        }

        if (savedDarkMode != null) {
          _isDarkMode = savedDarkMode;
          loadedFromSharedPrefs = true;
        }
      } catch (e) {
        // If shared_preferences fails, try ThemeStorage
        AppLogger.warning('Failed to load from shared_preferences: $e');
      }

      // If shared_preferences failed or had no data, try ThemeStorage
      if (!loadedFromSharedPrefs) {
        try {
          final storagePrefs = await ThemeStorage.loadPreferences();
          final savedVariantIndex = storagePrefs[_themeVariantKey] as int?;
          final savedDarkMode = storagePrefs[_darkModeKey] as bool?;

          if (savedVariantIndex != null &&
              savedVariantIndex >= 0 &&
              savedVariantIndex < AppThemeVariant.values.length) {
            _currentVariant = AppThemeVariant.values[savedVariantIndex];
          }

          if (savedDarkMode != null) {
            _isDarkMode = savedDarkMode;
          }

          AppLogger.info('Loaded theme preferences from ThemeStorage');
        } catch (e) {
          AppLogger.warning('Failed to load from ThemeStorage: $e');
          // Use defaults
          _currentVariant = AppThemeVariant.minimal;
          _isDarkMode = false;
        }
      }

      _cachedThemeData = _buildThemeData();
    }, operationName: 'initializeTheme');
  }

  /// Changes the theme variant
  Future<void> changeThemeVariant(AppThemeVariant variant) async {
    await executeAsync(() async {
      if (_currentVariant != variant) {
        _currentVariant = variant;
        _cachedThemeData = null;

        // Save preference to storage
        try {
          await _prefs?.setInt(_themeVariantKey, variant.index);
        } catch (e) {
          AppLogger.warning(
            'Failed to save theme variant to shared_preferences: $e',
          );
          // Fallback to ThemeStorage
          try {
            await ThemeStorage.savePreferences(
              themeVariantIndex: variant.index,
              isDarkMode: _isDarkMode,
            );
            AppLogger.info('Saved theme variant to ThemeStorage');
          } catch (storageError) {
            AppLogger.warning('Failed to save to ThemeStorage: $storageError');
          }
        }
        notifyListeners();
      }
    }, operationName: 'changeThemeVariant');
  }

  /// Toggles dark mode
  Future<void> toggleDarkMode() async {
    await executeAsync(() async {
      _isDarkMode = !_isDarkMode;
      _cachedThemeData = null;

      // Save preference to storage
      try {
        await _prefs?.setBool(_darkModeKey, _isDarkMode);
      } catch (e) {
        AppLogger.warning('Failed to save dark mode to shared_preferences: $e');
        // Fallback to ThemeStorage
        try {
          await ThemeStorage.savePreferences(
            themeVariantIndex: _currentVariant.index,
            isDarkMode: _isDarkMode,
          );
          AppLogger.info('Saved dark mode to ThemeStorage');
        } catch (storageError) {
          AppLogger.warning('Failed to save to ThemeStorage: $storageError');
        }
      }
      notifyListeners();
    }, operationName: 'toggleDarkMode');
  }

  /// Sets dark mode explicitly
  Future<void> setDarkMode(bool enabled) async {
    await executeAsync(() async {
      if (_isDarkMode != enabled) {
        _isDarkMode = enabled;
        _cachedThemeData = null;

        // Save preference to storage
        try {
          await _prefs?.setBool(_darkModeKey, _isDarkMode);
        } catch (e) {
          AppLogger.warning(
            'Failed to save dark mode to shared_preferences: $e',
          );
          // Fallback to ThemeStorage
          try {
            await ThemeStorage.savePreferences(
              themeVariantIndex: _currentVariant.index,
              isDarkMode: _isDarkMode,
            );
            AppLogger.info('Saved dark mode to ThemeStorage');
          } catch (storageError) {
            AppLogger.warning('Failed to save to ThemeStorage: $storageError');
          }
        }
        notifyListeners();
      }
    }, operationName: 'setDarkMode');
  }

  /// Gets the theme name for display
  String getThemeName(AppThemeVariant variant) {
    switch (variant) {
      case AppThemeVariant.minimal:
        return 'Minimal';
      case AppThemeVariant.tech:
        return 'Tech';
      case AppThemeVariant.modern:
        return 'Modern';
    }
  }

  /// Gets all available theme variants
  List<AppThemeVariant> get availableVariants => AppThemeVariant.values;

  /// Gets icon for theme variant
  IconData getThemeIcon(AppThemeVariant variant) {
    switch (variant) {
      case AppThemeVariant.minimal:
        return Icons.format_paint;
      case AppThemeVariant.tech:
        return Icons.memory;
      case AppThemeVariant.modern:
        return Icons.palette;
    }
  }

  /// Gets color for theme variant (for UI indicators)
  Color getThemeColor(AppThemeVariant variant) {
    final scheme = AppThemeFactory.getColorScheme(variant, darkMode: false);
    return scheme.primary;
  }

  /// Checks if a theme variant is currently selected
  bool isSelected(AppThemeVariant variant) => _currentVariant == variant;

  /// Builds the theme data based on current settings
  ThemeData _buildThemeData() {
    return AppThemeFactory.getTheme(_currentVariant, darkMode: _isDarkMode);
  }

  /// Resets to default theme settings
  Future<void> resetToDefaults() async {
    await executeAsync(() async {
      _currentVariant = AppThemeVariant.minimal;
      _isDarkMode = false;
      _cachedThemeData = null;

      // Clear saved preferences
      try {
        await _prefs?.remove(_themeVariantKey);
        await _prefs?.remove(_darkModeKey);
      } catch (e) {
        AppLogger.warning(
          'Failed to clear theme preferences from shared_preferences: $e',
        );
      }

      // Also clear from ThemeStorage
      try {
        await ThemeStorage.clearPreferences();
        AppLogger.info('Cleared theme preferences from ThemeStorage');
      } catch (e) {
        AppLogger.warning(
          'Failed to clear theme preferences from ThemeStorage: $e',
        );
      }

      notifyListeners();
    }, operationName: 'resetTheme');
  }

  /// Gets theme preview data for UI display
  Map<String, dynamic> getThemePreview(AppThemeVariant variant) {
    final scheme = AppThemeFactory.getColorScheme(variant, darkMode: false);

    return {
      'name': getThemeName(variant),
      'icon': getThemeIcon(variant),
      'primaryColor': scheme.primary,
      'secondaryColor': scheme.secondary,
      'surfaceColor': scheme.surface,
      'isSelected': isSelected(variant),
    };
  }

  /// Gets all theme previews
  List<Map<String, dynamic>> getAllThemePreviews() {
    return availableVariants
        .map((variant) => getThemePreview(variant))
        .toList();
  }

  /// Gets current theme settings for debugging
  Map<String, dynamic> getCurrentSettings() {
    return {
      'variant': getThemeName(_currentVariant),
      'variantIndex': _currentVariant.index,
      'darkMode': _isDarkMode,
      'isDarkMode': _isDarkMode,
    };
  }
}
