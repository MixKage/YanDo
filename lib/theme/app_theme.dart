import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yando/theme/extension_theme.dart';

class AppTheme {
  static final ThemeData themeLight = ThemeData(
    textTheme: _textTheme.apply(
      bodyColor: const Color(0xFF000000),
      displayColor: const Color(0xFF000000),
      decorationColor: const Color(0xFF000000),
    ),
    brightness: Brightness.light,
    primaryColor: const Color(0xFF007AFF),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Color(0xFF007AFF),
      foregroundColor: Color(0xFFFFFFFF),
    ),
    dividerColor: const Color(0x33000000),
    secondaryHeaderColor: const Color(0x99000000),
    scaffoldBackgroundColor: const Color(0xFFF7F6F2),
    dividerTheme: const DividerThemeData(
      color: Color(0x34C759FF),
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStateProperty.all(
        const Color(0x33000000),
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFFF7F6F2),
    ),
    inputDecorationTheme: InputDecorationTheme(
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          color: Colors.transparent,
        ),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          color: Colors.transparent,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          color: Colors.transparent,
        ),
      ),
      filled: true,
      fillColor: const Color(0xFFFFFFFF),
    ),
    extensions: const <ThemeExtension<dynamic>>[
      MyExtension(
        error: Color(0xFFFF3B30),
        grey: Color(0xFF8E8E93),
        green: Color(0xFF34C759),
      ),
    ],
    useMaterial3: false,
  );

  static final ThemeData themeDark = ThemeData(
    textTheme: _textTheme.apply(
      bodyColor: const Color(0xFFFFFFFF),
      displayColor: const Color(0xFFFFFFFF),
      decorationColor: const Color(0xFFFFFFFF),
    ),
    brightness: Brightness.dark,
    cardColor: const Color(0xFF252528),
    primaryColor: const Color(0xFF0A84FF),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Color(0xFF0A84FF),
      foregroundColor: Color(0xFFFFFFFF),
    ),
    dividerColor: const Color(0x33FFFFFF),
    secondaryHeaderColor: const Color(0x99FFFFFF),
    scaffoldBackgroundColor: const Color(0xFF161618),
    dividerTheme: const DividerThemeData(
      color: Color(0x33FFFFFF),
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStateProperty.all(
        const Color(0x33FFFFFF),
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF161618),
    ),
    inputDecorationTheme: InputDecorationTheme(
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          color: Colors.transparent,
        ),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          color: Colors.transparent,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          color: Colors.transparent,
        ),
      ),
      filled: true,
      fillColor: const Color(0xFF252528),
    ),
    extensions: const <ThemeExtension<dynamic>>[
      MyExtension(
        error: Color(0xFFFF453A),
        grey: Color(0xFF8E8E93),
        green: Color(0xFF32D74B),
      ),
    ],
    useMaterial3: false,
  );

  static final TextTheme _textTheme = GoogleFonts.robotoTextTheme(
    const TextTheme(
      // Large title
      headlineSmall: TextStyle(
        fontSize: 32,
        height: 38 / 32,
        fontWeight: FontWeight.w500,
      ),
      // Title
      titleLarge: TextStyle(
        fontSize: 20,
        height: 32 / 20,
        fontWeight: FontWeight.w500,
      ),
      // Button
      labelLarge: TextStyle(
        fontSize: 14,
        height: 24 / 14,
        fontWeight: FontWeight.w500,
      ),
      // Body
      bodyLarge: TextStyle(
        fontSize: 16,
        height: 20 / 16,
        fontWeight: FontWeight.w400,
      ),
      // Text Field
      bodyMedium: TextStyle(
        fontSize: 16,
        height: 18 / 16,
        fontWeight: FontWeight.w400,
      ),
      // Subhead
      titleMedium: TextStyle(
        fontSize: 14,
        height: 20 / 14,
        fontWeight: FontWeight.w400,
      ),
    ),
  );
}
