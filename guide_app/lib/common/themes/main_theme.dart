import 'package:flutter/material.dart';

class MainTheme {

  Color surface = const Color(0xFFF1F1F1);
  Color onSurface = const Color(0xFF2E1A7E);
  Color secondaryContainer = const Color(0xFFBDBDBD).withOpacity(0.35);
  Color readableText = Colors.black;
  Color onSurfaceVariant = const Color(0xFF2E1A7E).withOpacity(0.4);

  ThemeData get lightTheme {
    return ThemeData(useMaterial3: true, colorScheme: ColorScheme(
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
