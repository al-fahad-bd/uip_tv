import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeClass {
  // Colors
  static const Color primaryColor = Color(0xff1E1E1E); // Dark background
  static const Color secondaryColor = Color(0xffFFA500); // Orange accent
  static const Color textColor = Colors.white;
  static const Color greyTextColor = Colors.white60;
  static const Color errorColor = Colors.red;

  // Text Styles
  static TextStyle headingTextStyle = GoogleFonts.roboto(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: textColor,
  );

  static TextStyle subHeadingTextStyle = GoogleFonts.roboto(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: textColor,
  );

  static TextStyle bodyTextStyle = GoogleFonts.roboto(
    fontSize: 16,
    color: textColor,
  );

  static TextStyle greyTextStyle = GoogleFonts.roboto(
    fontSize: 14,
    color: greyTextColor,
  );

  // Button Styles
  static ButtonStyle primaryButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: secondaryColor,
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
  );

  // Card Styles
  static BoxDecoration cardDecoration = BoxDecoration(
    color: Colors.grey[900],
    borderRadius: BorderRadius.circular(12),
    boxShadow: [
      BoxShadow(
        color: Color.fromRGBO(0, 0, 0, 0.2),
        blurRadius: 6,
        offset: const Offset(0, 3),
      ),
    ],
  );

  // App Theme
  static ThemeData appTheme = ThemeData(
    primaryColor: primaryColor,
    scaffoldBackgroundColor: primaryColor,
    appBarTheme: AppBarTheme(
      backgroundColor: primaryColor,
      elevation: 0,
      titleTextStyle: headingTextStyle.copyWith(fontSize: 24),
    ),
    textTheme: TextTheme(
      displayLarge: headingTextStyle,
      displayMedium: subHeadingTextStyle,
      bodyLarge: bodyTextStyle,
      bodyMedium: greyTextStyle,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(style: primaryButtonStyle),
  );
}
