import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class ThemeStorage {
  Future<void> saveThemeMode(ThemeMode themeMode) async {
    final themeBox = await Hive.openBox('themeBox');
    await themeBox.put('themeMode', themeMode.index);
    await themeBox.close();
  }

  Future<ThemeMode> loadThemeMode() async {
    final themeBox = await Hive.openBox('themeBox');
    final int themeModeIndex = themeBox.get('themeMode', defaultValue: 0);
    await themeBox.close();
    return ThemeMode.values[themeModeIndex];
  }
}
