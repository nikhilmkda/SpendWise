import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    background: Colors.black87,
    primary: Colors.white,
    secondary: Colors.grey.shade600,
    inverseSurface: Colors.white,
  ),
  textTheme: TextTheme(
    displayLarge: GoogleFonts.roboto(
        color: Colors.white, fontSize: 25, fontWeight: FontWeight.w500),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Colors.amber,
  ),
);
