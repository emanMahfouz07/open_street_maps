// theme_service.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app_theme.dart';

class ThemeService extends ChangeNotifier {
  static const String _themeKey = 'theme_mode';

  final SharedPreferences _prefs;
  ThemeMode _themeMode;

  ThemeService._(this._prefs, this._themeMode);

  static Future<ThemeService> initialize() async {
    final prefs = await SharedPreferences.getInstance();
    final savedTheme = prefs.getString(_themeKey);

    ThemeMode mode;
    switch (savedTheme) {
      case 'light':
        mode = ThemeMode.light;
        break;
      case 'dark':
        mode = ThemeMode.dark;
        break;
      default:
        mode = ThemeMode.system;
    }

    final service = ThemeService._(prefs, mode);

    // تطبيق SystemUiOverlayStyle عند الإقلاع
    service._applyOverlayFor(mode);

    return service;
  }

  ThemeMode get themeMode => _themeMode;

  bool get isDarkMode => _themeMode == ThemeMode.dark;
  bool get isLightMode => _themeMode == ThemeMode.light;
  bool get isSystemMode => _themeMode == ThemeMode.system;

  Future<void> setThemeMode(ThemeMode mode) async {
    if (_themeMode == mode) return;

    _themeMode = mode;
    notifyListeners();

    // طبّق overlay بعد تغيّر الثيم
    _applyOverlayFor(mode);

    String value;
    switch (mode) {
      case ThemeMode.light:
        value = 'light';
        break;
      case ThemeMode.dark:
        value = 'dark';
        break;
      case ThemeMode.system:
        value = 'system';
        break;
    }

    await _prefs.setString(_themeKey, value);
  }

  Future<void> toggleTheme() async {
    if (_themeMode == ThemeMode.light) {
      await setThemeMode(ThemeMode.dark);
    } else {
      await setThemeMode(ThemeMode.light);
    }
  }

  void _applyOverlayFor(ThemeMode mode) {
    Brightness br;
    if (mode == ThemeMode.system) {
      br = WidgetsBinding.instance.platformDispatcher.platformBrightness;
    } else {
      br = (mode == ThemeMode.dark) ? Brightness.dark : Brightness.light;
    }

    final overlay = AppTheme.overlayFor(br);
    SystemChrome.setSystemUIOverlayStyle(overlay);
  }
}
