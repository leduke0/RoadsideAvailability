import 'package:chop_ya/src/utils/theme/widget_themes/text_themes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TAppTheme {
  TAppTheme._();

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: const MaterialColor(0xFF36454f, {
      50: Color(0xFF36454f),
      100: Color(0xFF36454f),
      200: Color(0xFF36454f),
      300: Color(0xFF36454f),
      400: Color(0xFF36454f),
      500: Color(0xFF36454f),
      600: Color(0xFF36454f),
      700: Color(0xFF36454f),
      800: Color(0xFF36454f),
      900: Color(0xFF36454f),
    }),
    textTheme: TTextTheme.lightTextTheme,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        primary: const Color(0xFF36454f),
        textStyle: GoogleFonts.roboto(
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    textTheme: TTextTheme.darkTextTheme,
    
  );
}
