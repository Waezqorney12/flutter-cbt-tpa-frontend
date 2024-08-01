import 'package:flutter/material.dart';
import 'package:test_potensial/core/theme/app_palette.dart';

class AppTheme {
  static _elevatedButton([Color color = AppPalette.primaryColor]) => ElevatedButton.styleFrom(
        fixedSize: const Size(450, 64),
        backgroundColor: color,
        shadowColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      );
  static _inputFormButton([Color color = AppPalette.primaryColor]) => OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: color,
          width: 1,
        ),
      );
  static final lightMode = ThemeData.light().copyWith(
    scaffoldBackgroundColor: Colors.white,
    elevatedButtonTheme: ElevatedButtonThemeData(style: _elevatedButton()),
    inputDecorationTheme: InputDecorationTheme(
      focusedBorder: _inputFormButton(),
      fillColor: AppPalette.filledInputColor,
      filled: true,
      errorBorder: _inputFormButton(),
      focusedErrorBorder: _inputFormButton(Colors.red),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.transparent),
      ),
    ),
  );
}
