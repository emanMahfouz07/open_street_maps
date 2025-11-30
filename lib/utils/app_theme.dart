import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTheme {
  // Light Theme Colors
  static const Color _lightPrimary = Color(0xFF2196F3);
  static const Color _lightSecondary = Color(0xFF03DAC6);
  static const Color _lightBackground = Colors.white;
  static const Color _lightSurface = Colors.white;

  // Dark Theme Colors
  static const Color _darkPrimary = Color(0xFFfff0f3);
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

    // AppBar Theme
    appBarTheme: const AppBarTheme(
      centerTitle: false,
      elevation: 0,
      backgroundColor: Colors.white,
      foregroundColor: Colors.black87,
      iconTheme: IconThemeData(color: Colors.black87),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness:
            Brightness.dark, // Dark icons on light background
        statusBarBrightness: Brightness.light, // For iOS
      ),
    ),

    // Card Theme
    cardTheme: CardTheme(
      elevation: 2,
      color: _lightSurface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),

    // FloatingActionButton Theme
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: _lightPrimary,
      foregroundColor: Colors.white,
      elevation: 4,
    ),

    // Input Decoration Theme
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

    // Bottom Sheet Theme
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: _lightSurface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
    ),

    // Icon Theme
    iconTheme: const IconThemeData(color: Colors.black87),

    // Text Theme
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
      headlineMedium: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
      bodyLarge: TextStyle(fontSize: 16, color: Colors.black87),
      bodyMedium: TextStyle(fontSize: 14, color: Colors.black87),
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
      error: Color(0xffFF758F),
    ),
    scaffoldBackgroundColor: _darkBackground,

    // AppBar Theme
    appBarTheme: AppBarTheme(
      centerTitle: false,
      elevation: 2,
      shadowColor: Colors.black.withOpacity(0.2),
      backgroundColor: _darkSurface,
      foregroundColor: Colors.white,
      iconTheme: const IconThemeData(color: Colors.white),
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness:
            Brightness.light, // Light icons on dark background
        statusBarBrightness: Brightness.dark, // For iOS
      ),
    ),

    // Card Theme
    cardTheme: CardTheme(
      elevation: 2,
      color: _darkSurface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),

    // FloatingActionButton Theme
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Color(0xffffe5d9),
      foregroundColor: Colors.black,
      elevation: 4,
    ),

    // Input Decoration Theme
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

    // Bottom Sheet Theme
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: _darkSurface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
    ),

    // Icon Theme
    iconTheme: const IconThemeData(color: Colors.white),

    // Text Theme
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      headlineMedium: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      bodyLarge: TextStyle(fontSize: 16, color: Colors.white),
      bodyMedium: TextStyle(fontSize: 14, color: Colors.white70),
    ),
  );

  static String getLightMapTileUrl() {
    return 'https://maps.geoapify.com/v1/tile/osm-bright/{z}/{x}/{y}.png?apiKey=29e466b51aed4732a5cef3f4aeec458a';
  }

  static String getDarkMapTileUrl() {
    return 'https://tile.openstreetmap.org/{z}/{x}/{y}.png?apiKey=29e466b51aed4732a5cef3f4aeec458a';
  }

  static SystemUiOverlayStyle overlayFor(Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    return SystemUiOverlayStyle(
      statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
      statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
      systemNavigationBarColor: isDark ? _darkSurface : _lightBackground,
      systemNavigationBarIconBrightness:
          isDark ? Brightness.light : Brightness.dark,
    );
  }
}
