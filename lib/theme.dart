import 'package:bible_app/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// App theme configuration with improved organization and consistency
class AppTheme {
  // Private constructor to prevent instantiation
  AppTheme._();

  /// Typography constants
  static const String _fontFamily = 'DM Sans';
  static const double _titleLargeFontSize = 24.0;
  static const double _displayMediumFontSize = 20.0;
  static const double _displaySmallFontSize = 16.0;
  static const double _displayLargeFontSize = 32.0;
  static const double _headlineLargeFontSize = 28.0;
  static const double _headlineSmallFontSize = 20.0;
  static const double _titleMediumFontSize = 18.0;
  static const double _bodyMediumFontSize = 14.0;
  static const double _bodySmallFontSize = 12.0;
  static const double _labelLargeFontSize = 14.0;
  static const double _labelMediumFontSize = 12.0;
  static const double _labelSmallFontSize = 10.0;
  static const double _searchBarFontSize = 16.0;

  /// Spacing and sizing constants
  static const double _dividerThickness = 1.0;
  static const double _searchBarElevation = 0.0;

  /// Main app theme
  static ThemeData get theme => ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: appColor,
        colorScheme: _colorScheme,
        fontFamily: _fontFamily,
        primaryColor: Colors.white,
        textTheme: _textTheme,
        textSelectionTheme: _textSelectionTheme,
        searchBarTheme: _searchBarTheme,
        appBarTheme: _appBarTheme,
        floatingActionButtonTheme: _floatingActionButtonTheme,
        navigationBarTheme: _navigationBarTheme,
        elevatedButtonTheme: _elevatedButtonTheme,
        textButtonTheme: _textButtonTheme,
        outlinedButtonTheme: _outlinedButtonTheme,
        cardTheme: _cardTheme,
        listTileTheme: _listTileTheme,
        inputDecorationTheme: _inputDecorationTheme,
        dividerTheme: _dividerTheme,
        pageTransitionsTheme: _pageTransitionsTheme,
        progressIndicatorTheme: _progressIndicatorTheme,
        snackBarTheme: _snackBarTheme,
      );

  /// Color scheme configuration
  static ColorScheme get _colorScheme => ColorScheme.fromSeed(
        seedColor: appColor,
        brightness: Brightness.dark,
      ).copyWith(
        primary: appColor,
        secondary: appColorDarker,
        surface: appColorDarker,
        surfaceTint: appColorDarker,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: Colors.white,
      );

  /// Text theme configuration
  static TextTheme get _textTheme => GoogleFonts.dmSansTextTheme(
        const TextTheme(
          displayLarge: TextStyle(
            color: Colors.white,
            fontSize: _displayLargeFontSize,
            fontWeight: FontWeight.w700,
          ),
          displayMedium: TextStyle(
            color: Colors.white,
            fontSize: _displayMediumFontSize,
            fontWeight: FontWeight.w600,
          ),
          displaySmall: TextStyle(
            color: Colors.white,
            fontSize: _displaySmallFontSize,
            fontWeight: FontWeight.w500,
          ),
          headlineLarge: TextStyle(
            color: Colors.white,
            fontSize: _headlineLargeFontSize,
            fontWeight: FontWeight.w700,
          ),
          headlineMedium: TextStyle(
            color: Colors.white,
            fontSize: _titleLargeFontSize,
            fontWeight: FontWeight.w700,
          ),
          headlineSmall: TextStyle(
            color: Colors.white,
            fontSize: _headlineSmallFontSize,
            fontWeight: FontWeight.w600,
          ),
          titleLarge: TextStyle(
            color: Colors.white,
            fontSize: _titleLargeFontSize,
            fontWeight: FontWeight.w700,
          ),
          titleMedium: TextStyle(
            color: Colors.white,
            fontSize: _titleMediumFontSize,
            fontWeight: FontWeight.w600,
          ),
          titleSmall: TextStyle(
            color: Colors.white,
            fontSize: _displaySmallFontSize,
            fontWeight: FontWeight.w500,
          ),
          bodyLarge: TextStyle(
            color: Colors.white,
            fontSize: _displaySmallFontSize,
          ),
          bodyMedium: TextStyle(
            color: Colors.white,
            fontSize: _bodyMediumFontSize,
          ),
          bodySmall: TextStyle(
            color: Colors.white70,
            fontSize: _bodySmallFontSize,
          ),
          labelLarge: TextStyle(
            color: Colors.white,
            fontSize: _labelLargeFontSize,
            fontWeight: FontWeight.w500,
          ),
          labelMedium: TextStyle(
            color: Colors.white,
            fontSize: _labelMediumFontSize,
            fontWeight: FontWeight.w500,
          ),
          labelSmall: TextStyle(
            color: Colors.white70,
            fontSize: _labelSmallFontSize,
            fontWeight: FontWeight.w500,
          ),
        ),
      );

  /// Text selection theme
  static TextSelectionThemeData get _textSelectionTheme =>
      TextSelectionThemeData(
        cursorColor: Colors.white,
        selectionColor: accentColor.withOpacity(0.3),
        selectionHandleColor: accentColor,
      );

  /// Search bar theme
  static SearchBarThemeData get _searchBarTheme => SearchBarThemeData(
        backgroundColor: WidgetStateProperty.all(appColor),
        elevation: WidgetStateProperty.all(_searchBarElevation),
        textStyle: WidgetStateProperty.all(
          const TextStyle(
            color: Colors.white,
            fontSize: _searchBarFontSize,
            fontFamily: _fontFamily,
          ),
        ),
        hintStyle: WidgetStateProperty.all(
          TextStyle(
            color: Colors.grey[400],
            fontSize: _searchBarFontSize,
            fontFamily: _fontFamily,
          ),
        ),
      );

  /// App bar theme
  static AppBarTheme get _appBarTheme => const AppBarTheme(
        backgroundColor: appColorDarker,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: _titleLargeFontSize,
          fontWeight: FontWeight.bold,
          fontFamily: _fontFamily,
        ),
        iconTheme: IconThemeData(
          color: Colors.white,
          size: 24,
        ),
        actionsIconTheme: IconThemeData(
          color: Colors.white,
          size: 24,
        ),
      );

  /// Floating action button theme
  static FloatingActionButtonThemeData get _floatingActionButtonTheme =>
      FloatingActionButtonThemeData(
        backgroundColor: accentColor,
        foregroundColor: Colors.white,
        elevation: 4,
        focusElevation: 6,
        hoverElevation: 8,
        highlightElevation: 12,
      );

  /// Navigation bar theme
  static NavigationBarThemeData get _navigationBarTheme =>
      NavigationBarThemeData(
        backgroundColor: appColorDarker,
        indicatorColor: Colors.grey[800],
        elevation: 8,
        height: 80,
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const IconThemeData(
              color: Colors.white,
              size: 28,
            );
          }
          return IconThemeData(
            color: Colors.grey[400],
            size: 24,
          );
        }),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w600,
              fontFamily: _fontFamily,
            );
          }
          return TextStyle(
            color: Colors.grey[400],
            fontSize: 12,
            fontFamily: _fontFamily,
          );
        }),
      );

  /// Elevated button theme
  static ElevatedButtonThemeData get _elevatedButtonTheme =>
      ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: appColor,
          foregroundColor: Colors.white,
          elevation: 2,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            fontFamily: _fontFamily,
          ),
        ),
      );

  /// Text button theme
  static TextButtonThemeData get _textButtonTheme => TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: accentColor,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            fontFamily: _fontFamily,
          ),
        ),
      );

  /// Outlined button theme
  static OutlinedButtonThemeData get _outlinedButtonTheme =>
      OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.white,
          side: const BorderSide(color: Colors.white, width: 1),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            fontFamily: _fontFamily,
          ),
        ),
      );

  /// Card theme
  static CardThemeData get _cardTheme => CardThemeData(
        color: appColorDarker,
        elevation: 2,
        shadowColor: Colors.black26,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      );

  /// List tile theme
  static ListTileThemeData get _listTileTheme => const ListTileThemeData(
        textColor: Colors.white,
        iconColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        dense: false,
        visualDensity: VisualDensity.comfortable,
      );

  /// Input decoration theme
  static InputDecorationTheme get _inputDecorationTheme => InputDecorationTheme(
        filled: true,
        fillColor: appColorDarker,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide(color: accentColor, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: const BorderSide(color: Colors.red, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
        hintStyle: TextStyle(
          color: Colors.grey[600],
          fontSize: _searchBarFontSize,
          fontFamily: _fontFamily,
        ),
        labelStyle: const TextStyle(
          color: Colors.black87,
          fontSize: _searchBarFontSize,
          fontFamily: _fontFamily,
        ),
      );

  /// Divider theme
  static DividerThemeData get _dividerTheme => const DividerThemeData(
        color: Colors.transparent,
        thickness: _dividerThickness,
        space: _dividerThickness,
      );

  /// Page transitions theme
  static PageTransitionsTheme get _pageTransitionsTheme =>
      const PageTransitionsTheme(
        builders: <TargetPlatform, PageTransitionsBuilder>{
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
        },
      );

  /// Progress indicator theme
  static ProgressIndicatorThemeData get _progressIndicatorTheme =>
      const ProgressIndicatorThemeData(
        color: Colors.white,
        linearTrackColor: Colors.white24,
        circularTrackColor: Colors.white24,
      );

  /// Snack bar theme
  static SnackBarThemeData get _snackBarTheme => SnackBarThemeData(
        backgroundColor: appColorDarker,
        contentTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontFamily: _fontFamily,
        ),
        actionTextColor: accentColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      );
}

/// Legacy theme export for backward compatibility
@Deprecated('Use AppTheme.theme instead')
ThemeData get theme => AppTheme.theme;
