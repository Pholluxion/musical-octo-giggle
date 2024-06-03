import 'package:flutter/material.dart';

final themeData = ThemeData(
  primaryColor: const Color(0xFF40FF5E),
  colorScheme: const ColorScheme.light(
    primary: Color(0xFF40FF5E),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF40FF5E),
    centerTitle: true,
    toolbarHeight: kToolbarHeight + 20,
    shape: OutlineInputBorder(
      borderRadius: BorderRadius.only(
        bottomRight: Radius.circular(20),
        topLeft: Radius.circular(20),
      ),
    ),
  ),
  cardTheme: const CardTheme(
    shape: OutlineInputBorder(
      borderRadius: BorderRadius.only(
        bottomRight: Radius.circular(20),
        topLeft: Radius.circular(20),
      ),
    ),
  ),
  inputDecorationTheme: const InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.only(
        bottomRight: Radius.circular(20),
        topLeft: Radius.circular(20),
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.only(
        bottomRight: Radius.circular(20),
        topLeft: Radius.circular(20),
      ),
      borderSide: BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.only(
        bottomRight: Radius.circular(20),
        topLeft: Radius.circular(20),
      ),
      borderSide: BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
    ),
  ),
  fontFamily: 'Roboto',
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
      backgroundColor: WidgetStateProperty.all<Color>(const Color(0xFF40FF5E)),
      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
        const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(20),
            topLeft: Radius.circular(20),
          ),
          side: BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
        ),
      ),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
        const EdgeInsets.symmetric(horizontal: 16),
      ),
      backgroundColor: WidgetStateProperty.all<Color>(const Color(0xFF40FF5E)),
      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
        const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(20),
            topLeft: Radius.circular(20),
          ),
          side: BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
        ),
      ),
    ),
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(fontSize: 16.0),
    bodyMedium: TextStyle(fontSize: 14.0),
    bodySmall: TextStyle(fontSize: 12.0),
    titleLarge: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
    titleMedium: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
    titleSmall: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
    labelLarge: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
    labelMedium: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
    labelSmall: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
    displayLarge: TextStyle(fontSize: 34.0, fontWeight: FontWeight.bold),
    displayMedium: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
    displaySmall: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
    headlineLarge: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
    headlineMedium: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
    headlineSmall: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
  ),
);
