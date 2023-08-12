import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    background: Colors.white,
    primary: Colors.black,
    secondary: Colors.grey.shade400,
    inverseSurface:Colors.black,
    
    
  ),
  textTheme: TextTheme(
    displayLarge: GoogleFonts.roboto(
        color: Colors.black, fontSize: 25, fontWeight: FontWeight.w500),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Colors.amber, 
  ),
);
