import 'package:flutter/material.dart';
import 'package:flutter_application_personal_expense_app/data/theme_save_hive.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _currentThemeMode;

  ThemeData _theme = ThemeData.dark();
  ThemeData get theme => _theme;

  void toggleThemeSwitch() {
    final isDark = _theme == ThemeData.light();
    _theme = isDark
        ? ThemeData.light()
        : ThemeData.dark(); // Toggle between light and dark themes.
    notifyListeners();
  }

  ThemeMode get currentThemeMode => _currentThemeMode;

  ThemeProvider(this._currentThemeMode);

  Future<void> toggleTheme() async {
    _currentThemeMode =
        _currentThemeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    final themeStorage = ThemeStorage();
    await themeStorage.saveThemeMode(_currentThemeMode);
    notifyListeners();
  }
}
