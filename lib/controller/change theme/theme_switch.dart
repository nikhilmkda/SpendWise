import 'package:flutter/material.dart';
import 'package:flutter_application_personal_expense_app/controller/change%20theme/theme_provider.dart';
import 'package:provider/provider.dart';

class ThemeSwitchButton extends StatelessWidget {
  const ThemeSwitchButton({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final currentThemeMode = themeProvider.currentThemeMode;

    return ElevatedButton(
      onPressed: () {
        themeProvider.toggleTheme();
      },
      child: Text(
        currentThemeMode == ThemeMode.light
            ? 'Switch to Dark Theme'
            : 'Switch to Light Theme',
      ),
    );
  }
}
