import 'package:bible_app/data/constants/colors.dart';
import 'package:bible_app/data/constants/constants.dart';
import 'package:bible_app/data/data.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData theme = ThemeData(
  scaffoldBackgroundColor: appColor,
  colorScheme: ColorScheme.fromSeed(seedColor: appColor).copyWith(
    primary: appColor,
    secondary: appColorDarker,
    surfaceTint: appColorDarker,
  ),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: Colors.white,
    selectionColor: accentColor.withOpacity(0.3),
    selectionHandleColor: accentColor,
  ),
  searchBarTheme: SearchBarThemeData(
    backgroundColor: WidgetStateProperty.all(appColor),
    elevation: WidgetStateProperty.all(0),
    textStyle: WidgetStateProperty.all(
      const TextStyle(color: Colors.white, fontSize: 16),
    ),
    hintStyle: WidgetStateProperty.all(
      TextStyle(color: Colors.grey[600], fontSize: 16),
    ),
  ),
  primaryColor: Colors.white,
  fontFamily: 'DM Sans',
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
    backgroundColor: appColorDarker,
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 24,
      fontWeight: FontWeight.bold,
      fontFamily: 'DM Sans',
    ),
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: accentColor,
  ),
  navigationBarTheme: NavigationBarThemeData(
    backgroundColor: appColorDarker,
    indicatorColor: Colors.grey[800],
    iconTheme: WidgetStateProperty.all(
      const IconThemeData(
        color: Colors.white,
      ),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.all(appColor),
      foregroundColor: WidgetStateProperty.all(accentColor),
    ),
  ),
  dividerTheme: const DividerThemeData(
    color: Colors.transparent,
    thickness: 1,
  ),
  pageTransitionsTheme: const PageTransitionsTheme(
    builders: <TargetPlatform, PageTransitionsBuilder>{
      TargetPlatform.android: CupertinoPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
    },
  ),
);
