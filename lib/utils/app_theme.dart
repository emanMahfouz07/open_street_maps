import 'package:flutter/material.dart';

class AppTheme {
  static const Color _lightPrimary = Color(0xFF2196F3);
  static const Color _lightSecondary = Color(0xFF03DAC6);
  static const Color _lightBackground = Color(0xFFF5F5F5);
  static const Color _lightSurface = Colors.white;

  // Dark Theme Colors
  static const Color _darkPrimary = Color(0xFF90CAF9);
  static const Color _darkSecondary = Color(0xFF03DAC6);
  static const Color _darkBackground = Color(0xFF121212);
  static const Color _darkSurface = Color(0xFF1E1E1E);

  // Light Theme
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
      primary: _lightPrimary,
      secondary: _lightSecondary,
      surface: _lightSurface,
      background: _lightBackground,
      error: Colors.red.shade700,
    ),
    scaffoldBackgroundColor: _lightBackground,

    appBarTheme: const AppBarTheme(
      centerTitle: false,
      elevation: 0,
      backgroundColor: _lightPrimary,
      foregroundColor: Colors.white,
      iconTheme: IconThemeData(color: Colors.white),
    ),

    cardTheme: CardTheme(
      elevation: 2,
      color: _lightSurface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),

    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: _lightPrimary,
      foregroundColor: Colors.white,
      elevation: 4,
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: _lightSurface,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: _lightPrimary, width: 2),
      ),
    ),

    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: _lightSurface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
    ),
  );

  // Dark Theme
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
      primary: _darkPrimary,
      secondary: _darkSecondary,
      surface: _darkSurface,
      background: _darkBackground,
      error: Colors.red.shade400,
    ),
    scaffoldBackgroundColor: _darkBackground,

    appBarTheme: const AppBarTheme(
      centerTitle: false,
      elevation: 0,
      backgroundColor: _darkSurface,
      foregroundColor: Colors.white,
      iconTheme: IconThemeData(color: Colors.white),
    ),

    cardTheme: CardTheme(
      elevation: 2,
      color: _darkSurface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),

    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: _darkPrimary,
      foregroundColor: Colors.black,
      elevation: 4,
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: _darkSurface,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: _darkPrimary, width: 2),
      ),
    ),

    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: _darkSurface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
    ),
  );

  static String getLightMapTileUrl() {
    return 'https://maps.geoapify.com/v1/tile/osm-bright/{z}/{x}/{y}.png?apiKey=29e466b51aed4732a5cef3f4aeec458a';
  }

  static String getDarkMapTileUrl() {
    return 'https://maps.geoapify.com/v1/tile/dark-matter/{z}/{x}/{y}.png?apiKey=29e466b51aed4732a5cef3f4aeec458a';
  }
}
