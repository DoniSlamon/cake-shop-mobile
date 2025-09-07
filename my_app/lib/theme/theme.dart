import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  useMaterial3: true,
  colorScheme: const ColorScheme.light(
    // Warm bakery-inspired palette
    background: Color(0xFFFFF8F0), // Vanilla cream background
    surface: Color(0xFFFFFBF7), // Pure cream surface
    primary: Color(0xFFD4A574), // Golden caramel
    primaryContainer: Color(0xFFF5E6D3), // Light caramel
    secondary: Color(0xFFE91E63), // Strawberry pink
    secondaryContainer: Color(0xFFFFF0F5), // Soft pink
    tertiary: Color(0xFF8D6E63), // Rich chocolate brown
    tertiaryContainer: Color(0xFFEFEBE9), // Light brown
    onPrimary: Colors.white,
    onSecondary: Colors.white,
    onTertiary: Colors.white,
    onSurface: Color(0xFF3E2723), // Dark chocolate text
    onBackground: Color(0xFF5D4037), // Medium brown text
    outline: Color(0xFFBCAAA4), // Soft brown outline
    outlineVariant: Color(0xFFE8D5CB), // Very light brown
  ),
  fontFamily: 'Roboto',
  textTheme: const TextTheme(
    headlineLarge: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: Color(0xFF3E2723),
    ),
    headlineMedium: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      color: Color(0xFF5D4037),
    ),
    bodyLarge: TextStyle(
      fontSize: 16,
      color: Color(0xFF5D4037),
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      color: Color(0xFF6D4C41),
    ),
  ),
  cardTheme: CardTheme(
    elevation: 8,
    shadowColor: Colors.black26,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFFD4A574), // Golden caramel
      foregroundColor: Colors.white,
      elevation: 6,
      shadowColor: const Color(0xFF8D6E63).withOpacity(0.3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
    ),
  ),
  
  // Additional theme components for better consistency
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Color(0xFFE91E63), // Strawberry pink
    foregroundColor: Colors.white,
    elevation: 8,
  ),
  
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFFD4A574), // Golden caramel
    foregroundColor: Colors.white,
    elevation: 4,
    centerTitle: true,
    titleTextStyle: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
  ),
);

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  useMaterial3: true,
  colorScheme: const ColorScheme.dark(
    // Dark bakery theme - cozy evening atmosphere
    background: Color(0xFF2E1A1A), // Dark chocolate background
    surface: Color(0xFF3A2626), // Dark cocoa surface
    primary: Color(0xFFFFB74D), // Warm golden orange
    primaryContainer: Color(0xFF8D6E63), // Medium brown
    secondary: Color(0xFFFF4081), // Bright strawberry
    secondaryContainer: Color(0xFF4A2C2A), // Dark pink
    tertiary: Color(0xFFD7CCC8), // Light cream
    tertiaryContainer: Color(0xFF5D4037), // Dark brown
    onPrimary: Color(0xFF2E1A1A),
    onSecondary: Colors.white,
    onTertiary: Color(0xFF2E1A1A),
    onSurface: Color(0xFFEFEBE9), // Cream text
    onBackground: Color(0xFFD7CCC8), // Light cream text
    outline: Color(0xFF8D6E63), // Medium brown outline
    outlineVariant: Color(0xFF5D4037), // Dark brown variant
  ),
  fontFamily: 'Roboto',
  textTheme: const TextTheme(
    headlineLarge: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: Color(0xFFEFEBE9),
    ),
    headlineMedium: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      color: Color(0xFFD7CCC8),
    ),
    bodyLarge: TextStyle(
      fontSize: 16,
      color: Color(0xFFD7CCC8),
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      color: Color(0xFFBCAAA4),
    ),
  ),
  cardTheme: CardTheme(
    elevation: 8,
    shadowColor: Colors.black54,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFFFFB74D), // Warm golden orange
      foregroundColor: const Color(0xFF2E1A1A),
      elevation: 6,
      shadowColor: Colors.black54,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
    ),
  ),
  
  // Additional dark theme components
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Color(0xFFFF4081), // Bright strawberry
    foregroundColor: Colors.white,
    elevation: 8,
  ),
  
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFFFFB74D), // Warm golden orange
    foregroundColor: Color(0xFF2E1A1A),
    elevation: 4,
    centerTitle: true,
    titleTextStyle: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: Color(0xFF2E1A1A),
    ),
  ),
);