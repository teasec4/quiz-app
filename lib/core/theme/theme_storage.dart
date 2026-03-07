import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:bookexample/core/logging/app_logger.dart';

/// Storage for theme preferences as fallback when shared_preferences fails
class ThemeStorage {
  static const String _fileName = 'theme_preferences.json';
  static const String _themeVariantKey = 'theme_variant';
  static const String _darkModeKey = 'dark_mode';

  /// Saves theme preferences to local file
  static Future<void> savePreferences({
    required int themeVariantIndex,
    required bool isDarkMode,
  }) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/$_fileName');

      final preferences = {
        _themeVariantKey: themeVariantIndex,
        _darkModeKey: isDarkMode,
        'timestamp': DateTime.now().toIso8601String(),
      };

      await file.writeAsString(jsonEncode(preferences));
      AppLogger.debug('Theme preferences saved to file');
    } catch (e) {
      AppLogger.warning('Failed to save theme preferences to file: $e');
      rethrow;
    }
  }

  /// Loads theme preferences from local file
  static Future<Map<String, dynamic>> loadPreferences() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/$_fileName');

      if (!await file.exists()) {
        AppLogger.debug(
          'Theme preferences file does not exist, using defaults',
        );
        return {_themeVariantKey: null, _darkModeKey: null};
      }

      final content = await file.readAsString();
      final preferences = jsonDecode(content) as Map<String, dynamic>;

      AppLogger.debug('Theme preferences loaded from file');
      return preferences;
    } catch (e) {
      AppLogger.warning('Failed to load theme preferences from file: $e');
      return {_themeVariantKey: null, _darkModeKey: null};
    }
  }

  /// Clears saved theme preferences
  static Future<void> clearPreferences() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/$_fileName');

      if (await file.exists()) {
        await file.delete();
        AppLogger.debug('Theme preferences file deleted');
      }
    } catch (e) {
      AppLogger.warning('Failed to clear theme preferences: $e');
    }
  }

  /// Gets the last modified time of preferences file
  static Future<DateTime?> getLastModified() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/$_fileName');

      if (await file.exists()) {
        final stat = await file.stat();
        return stat.modified;
      }
      return null;
    } catch (e) {
      AppLogger.warning('Failed to get file modification time: $e');
      return null;
    }
  }

  /// Checks if preferences file exists
  static Future<bool> preferencesExist() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/$_fileName');
      return await file.exists();
    } catch (e) {
      AppLogger.warning('Failed to check if preferences file exists: $e');
      return false;
    }
  }

  /// Gets file path for debugging
  static Future<String?> getFilePath() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      return '${directory.path}/$_fileName';
    } catch (e) {
      return null;
    }
  }
}
