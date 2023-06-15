import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData theme([isDark = true]) => ThemeData(
        textTheme: _textTheme(isDark),
        brightness: isDark ? Brightness.dark : Brightness.light,
        cardColor: isDark ? const Color(0xFF252528) : null,
        primaryColor:
            isDark ? const Color(0xFF0A84FF) : const Color(0xFF007AFF),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor:
              isDark ? const Color(0xFF0A84FF) : const Color(0xFF007AFF),
          foregroundColor: const Color(0xFFFFFFFF),
        ),
        dividerColor:
            isDark ? const Color(0x33FFFFFF) : const Color(0x33000000),
        secondaryHeaderColor:
            isDark ? const Color(0x99FFFFFF) : const Color(0x99000000),
        scaffoldBackgroundColor:
            isDark ? const Color(0xFF161618) : const Color(0xFFF7F6F2),
        dividerTheme: DividerThemeData(
          color: isDark ? const Color(0x33FFFFFF) : const Color(0x34C759FF),
        ),
        checkboxTheme: CheckboxThemeData(
          fillColor: MaterialStateProperty.all(
            isDark ? const Color(0x33FFFFFF) : const Color(0x33000000),
          ),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor:
              isDark ? const Color(0xFF161618) : const Color(0xFFF7F6F2),
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
          fillColor: isDark ? const Color(0xFF252528) : const Color(0xFFFFFFFF),
        ),
        // InputDecorationTheme(
        //   fillColor: isDark ? const Color(0xFF252528)
        //   : const Color(0xFFFFFFFF),
        // ),
        useMaterial3: false,
      );

  static TextTheme _textTheme(bool isDark) => GoogleFonts.robotoTextTheme(
        TextTheme(
          // Large title
          headlineSmall: TextStyle(
            fontSize: 32,
            height: 38 / 32,
            fontWeight: FontWeight.w500,
            color: isDark ? const Color(0xFFFFFFFF) : const Color(0xFF000000),
          ),
          // Title
          titleLarge: TextStyle(
            fontSize: 20,
            height: 32 / 20,
            fontWeight: FontWeight.w500,
            color: isDark ? const Color(0xFFFFFFFF) : const Color(0xFF000000),
          ),
          // Button
          labelLarge: TextStyle(
            fontSize: 14,
            height: 24 / 14,
            fontWeight: FontWeight.w500,
            color: isDark ? const Color(0xFFFFFFFF) : const Color(0xFF000000),
          ),
          // Body
          bodyLarge: TextStyle(
            fontSize: 16,
            height: 20 / 16,
            fontWeight: FontWeight.w400,
            color: isDark ? const Color(0xFFFFFFFF) : const Color(0xFF000000),
          ),
          // Text Field
          bodyMedium: const TextStyle(
            fontSize: 16,
            height: 18 / 16,
            fontWeight: FontWeight.w400,
          ),
          // Subhead
          titleMedium: const TextStyle(
            fontSize: 14,
            height: 20 / 14,
            fontWeight: FontWeight.w400,
          ),
        ),
      );
}
