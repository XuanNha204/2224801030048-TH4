import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends ChangeNotifier {
  ThemeController([this._isDark = false, this._preferences]);

  static const _themeKey = 'dark_theme_enabled';

  bool _isDark;
  final SharedPreferences? _preferences;

  bool get isDark => _isDark;
  ThemeMode get themeMode => _isDark ? ThemeMode.dark : ThemeMode.light;

  static Future<ThemeController> load() async {
    final preferences = await SharedPreferences.getInstance();
    return ThemeController(
      preferences.getBool(_themeKey) ?? false,
      preferences,
    );
  }

  Future<void> setDarkMode(bool enabled) async {
    if (_isDark == enabled) return;
    _isDark = enabled;
    notifyListeners();
    await _preferences?.setBool(_themeKey, enabled);
  }
}
