import 'package:bible_app/data/data.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData theme = ThemeData(
  scaffoldBackgroundColor: appColor,
  primaryColor: Colors.white,
  useMaterial3: false,
  textTheme: GoogleFonts.dmSansTextTheme(
    const TextTheme(
      titleLarge: TextStyle(
        color: Colors.white,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      displayMedium: TextStyle(
        color: Colors.white,
        fontSize: 20,
      ),
      displaySmall: TextStyle(
        color: Colors.white,
        fontSize: 16,
      ),
    ),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: appColor,
    elevation: 0,
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: accentColor,
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: appColor,
    selectedItemColor: Colors.white,
    unselectedItemColor: Colors.grey,
  ),
);
