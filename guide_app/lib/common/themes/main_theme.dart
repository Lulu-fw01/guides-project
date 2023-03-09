import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MainTheme {
  Color surface = const Color(0xFFF1F1F1);
  Color onSurface = const Color(0xFF2E1A7E);
  Color secondaryContainer = const Color(0xFFBDBDBD).withOpacity(0.35);
  static const Color readableText = Colors.black;
  Color onSurfaceVariant = const Color(0xFF2E1A7E).withOpacity(0.4);
  TextStyle smallInfoTextAuthor =
      GoogleFonts.lato(fontSize: 12, fontWeight: FontWeight.w400);
  TextStyle smallInfoText = GoogleFonts.lato(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: const Color(0xFF2E1A7E).withOpacity(0.4));
  TextStyle titleText = GoogleFonts.lato(
      fontSize: 24,
      fontWeight: FontWeight.w400,
      color: const Color(0xFF2E1A7E));
  TextStyle informationText = GoogleFonts.lato(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: readableText);

  ThemeData get lightTheme {
    return ThemeData(
        useMaterial3: true,
        textSelectionTheme: TextSelectionThemeData(cursorColor: onSurface),
        colorScheme: ColorScheme(
          surface: surface,
          onSurface: onSurface,
          secondaryContainer: secondaryContainer,
          onSurfaceVariant: onSurfaceVariant,
          background: Colors.white,
          brightness: Brightness.light,
          error: Colors.red,
          onBackground: Colors.black,
          onError: Colors.white,
          onPrimary: Colors.black,
          onSecondary: Colors.black,
          primary: Colors.white,
          secondary: Colors.grey,
        ));
  }
}
