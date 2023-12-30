import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData mainTheme() => ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        fontFamily: GoogleFonts.montserrat().fontFamily,
        appBarTheme: const AppBarTheme(centerTitle: true),
        useMaterial3: true,
      );
}
