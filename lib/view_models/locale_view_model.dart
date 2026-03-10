import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bookexample/view_models/base_view_model.dart';
import 'package:bookexample/core/logging/app_logger.dart';
import 'package:bookexample/l10n/app_localizations.dart';

/// ViewModel for managing application locale (language) settings.
/// Provides centralized locale management with persistence support.
class LocaleViewModel extends BaseViewModel {
  static const String _localeKey = 'app_locale';

  /// Current locale
  Locale _currentLocale = const Locale('en', 'US');

  /// Supported locales in the application
  final List<Locale> _supportedLocales = const [
    Locale('en', 'US'), // English (United States)
    Locale('ru', 'RU'), // Russian (Russia)
    Locale('zh', 'CN'), // Chinese (China)
  ];

  /// Gets the current locale
  Locale get currentLocale => _currentLocale;

  /// Gets all supported locales
  List<Locale> get supportedLocales => List.from(_supportedLocales);

  /// Gets the current locale code (e.g., 'en_US')
  String get currentLocaleCode {
    final countryCode = _currentLocale.countryCode ?? '';
    return countryCode.isNotEmpty
        ? '${_currentLocale.languageCode}_$countryCode'
        : _currentLocale.languageCode;
  }

  /// Gets locale display name for UI
  String getLocaleDisplayName(Locale locale, BuildContext context) {
    switch (locale.languageCode) {
      case 'en':
        return AppLocalizations.of(context)?.english ?? 'English';
      case 'ru':
        return AppLocalizations.of(context)?.russian ?? 'Русский';
      case 'zh':
        return AppLocalizations.of(context)?.chinese ?? '中文';
      default:
        return locale.languageCode.toUpperCase();
    }
  }

  /// Gets locale flag emoji for UI
  String getLocaleFlag(Locale locale) {
    switch (locale.languageCode) {
      case 'en':
        return '🇺🇸';
      case 'ru':
        return '🇷🇺';
      case 'zh':
        return '🇨🇳';
      default:
        return '🌐';
    }
  }

  /// Initializes the locale view model with saved preferences
  Future<void> initialize() async {
    await executeAsync(() async {
      try {
        final prefs = await SharedPreferences.getInstance();
        final savedLocaleCode = prefs.getString(_localeKey);

        if (savedLocaleCode != null && savedLocaleCode.isNotEmpty) {
          final locale = _parseLocaleCode(savedLocaleCode);
          if (locale != null && _isLocaleSupported(locale)) {
            _currentLocale = locale;
            AppLogger.debug('Loaded locale: $savedLocaleCode');
          }
        }
      } catch (e) {
        AppLogger.warning('Failed to load locale preferences: $e');
        // Use default locale
        _currentLocale = const Locale('en', 'US');
      }
    }, operationName: 'initializeLocale');
  }

  /// Changes the application locale
  Future<void> setLocale(Locale locale) async {
    await executeAsync(() async {
      if (!_isLocaleSupported(locale)) {
        throw ArgumentError('Locale $locale is not supported');
      }

      if (_currentLocale != locale) {
        _currentLocale = locale;

        try {
          final prefs = await SharedPreferences.getInstance();
          final localeCode = locale.countryCode != null
              ? '${locale.languageCode}_${locale.countryCode}'
              : locale.languageCode;
          await prefs.setString(_localeKey, localeCode);
          AppLogger.debug('Saved locale: $localeCode');
        } catch (e) {
          AppLogger.warning('Failed to save locale preferences: $e');
        }

        notifyListeners();
      }
    }, operationName: 'setLocale');
  }

  /// Changes locale by language code
  Future<void> setLocaleByCode(
    String languageCode, {
    String? countryCode,
  }) async {
    final locale = countryCode != null
        ? Locale(languageCode, countryCode)
        : Locale(languageCode);
    await setLocale(locale);
  }

  /// Checks if a locale is currently selected
  bool isLocaleSelected(Locale locale) {
    return _currentLocale.languageCode == locale.languageCode &&
        _currentLocale.countryCode == locale.countryCode;
  }

  /// Resets to default locale (English)
  Future<void> resetToDefault() async {
    await executeAsync(() async {
      _currentLocale = const Locale('en', 'US');

      try {
        final prefs = await SharedPreferences.getInstance();
        await prefs.remove(_localeKey);
        AppLogger.debug('Reset locale to default');
      } catch (e) {
        AppLogger.warning('Failed to reset locale preferences: $e');
      }

      notifyListeners();
    }, operationName: 'resetLocale');
  }

  /// Gets locale information for UI display
  Map<String, dynamic> getLocaleInfo(Locale locale, BuildContext context) {
    return {
      'locale': locale,
      'displayName': getLocaleDisplayName(locale, context),
      'flag': getLocaleFlag(locale),
      'languageCode': locale.languageCode,
      'countryCode': locale.countryCode,
      'isSelected': isLocaleSelected(locale),
    };
  }

  /// Gets all locale information for UI display
  List<Map<String, dynamic>> getAllLocaleInfo(BuildContext context) {
    return supportedLocales
        .map((locale) => getLocaleInfo(locale, context))
        .toList();
  }

  /// Gets current locale settings for debugging
  Map<String, dynamic> getCurrentSettings(BuildContext context) {
    return {
      'languageCode': _currentLocale.languageCode,
      'countryCode': _currentLocale.countryCode,
      'localeCode': currentLocaleCode,
      'displayName': getLocaleDisplayName(_currentLocale, context),
    };
  }

  /// Parses locale code string to Locale object
  Locale? _parseLocaleCode(String localeCode) {
    try {
      final parts = localeCode.split('_');
      if (parts.length == 2) {
        return Locale(parts[0], parts[1]);
      } else if (parts.length == 1) {
        return Locale(parts[0]);
      }
    } catch (e) {
      AppLogger.warning('Failed to parse locale code: $localeCode, error: $e');
    }
    return null;
  }

  /// Checks if locale is supported
  bool _isLocaleSupported(Locale locale) {
    return supportedLocales.any(
      (supported) =>
          supported.languageCode == locale.languageCode &&
          supported.countryCode == locale.countryCode,
    );
  }

  /// Gets system locale (for auto-detection)
  Locale getSystemLocale() {
    final platformLocale = WidgetsBinding.instance.window.locale;

    // Try to find exact match
    for (final supported in supportedLocales) {
      if (supported.languageCode == platformLocale.languageCode &&
          supported.countryCode == platformLocale.countryCode) {
        return supported;
      }
    }

    // Try to find language match
    for (final supported in supportedLocales) {
      if (supported.languageCode == platformLocale.languageCode) {
        return supported;
      }
    }

    // Default to English
    return const Locale('en', 'US');
  }

  /// Auto-detects and sets system locale
  Future<void> setSystemLocale() async {
    final systemLocale = getSystemLocale();
    await setLocale(systemLocale);
  }
}
