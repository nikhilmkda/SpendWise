import 'package:flutter/material.dart';
import 'package:flutter_application_personal_expense_app/controller/change%20theme/theme_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ThemeSwitchButton extends StatelessWidget {
  const ThemeSwitchButton({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final currentThemeMode = themeProvider.currentThemeMode;

    return SwitchListTile(
      value: currentThemeMode == ThemeMode.dark,
      onChanged: (value) {
        themeProvider.toggleTheme();
      },
      title: currentThemeMode == ThemeMode.light
          ? Text(
              'Turn On Dark Theme',
              style: GoogleFonts.roboto(
                fontSize: 18,
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            )
          : Text(
              'Turn Off Dark Theme',
              style: GoogleFonts.roboto(
                fontSize: 18,
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
      activeColor: Colors.grey.shade300,
      inactiveThumbColor: Colors.black87,
      activeTrackColor: Colors.green,
      inactiveTrackColor: Colors.grey,
      contentPadding: EdgeInsets.symmetric(horizontal: 20),
    );
  }
}
