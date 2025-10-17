import 'package:flutter/material.dart';

class AppTheme {
  static ColorScheme get lightColorScheme => ColorScheme.fromSeed(
        seedColor: Colors.blue.shade700,
        brightness: Brightness.light,
      );

  static ColorScheme get darkColorScheme => ColorScheme.fromSeed(
        seedColor: Colors.blue.shade700,
        brightness: Brightness.dark,
      );

  static ThemeData get lightTheme => ThemeData(
        useMaterial3: true,
        colorScheme: lightColorScheme,
        appBarTheme: AppBarTheme(
          backgroundColor: lightColorScheme.primary,
          foregroundColor: lightColorScheme.onPrimary,
          elevation: 0,
          centerTitle: true,
        ),
        scaffoldBackgroundColor: lightColorScheme.background,
        textTheme: const TextTheme(
          headlineLarge: TextStyle(fontWeight: FontWeight.bold),
          bodyMedium: TextStyle(fontSize: 16),
        ),
        cardTheme: CardThemeData(
          color: lightColorScheme.surface,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: lightColorScheme.surface,
          selectedItemColor: lightColorScheme.primary,
          unselectedItemColor: lightColorScheme.onSurface.withOpacity(0.6),
        ),
      );

  static ThemeData get darkTheme => ThemeData(
        useMaterial3: true,
        colorScheme: darkColorScheme,
        appBarTheme: AppBarTheme(
          backgroundColor: darkColorScheme.primary,
          foregroundColor: darkColorScheme.onPrimary,
          elevation: 0,
          centerTitle: true,
        ),
        scaffoldBackgroundColor: darkColorScheme.background,
        textTheme: const TextTheme(
          headlineLarge: TextStyle(fontWeight: FontWeight.bold),
          bodyMedium: TextStyle(fontSize: 16),
        ),
        cardTheme: CardThemeData(
          color: darkColorScheme.surface,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: darkColorScheme.surface,
          selectedItemColor: darkColorScheme.primary,
          unselectedItemColor: darkColorScheme.onSurface.withOpacity(0.6),
        ),
      );
} 