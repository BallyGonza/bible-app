import 'package:bible_app/core/core.dart';
import 'package:flutter/material.dart';

/// Handles application initialization tasks
/// Separates initialization logic from main() for better testability
class AppInitializer {
  /// Initializes all required services before app startup
  /// Returns true if initialization was successful
  static Future<bool> initialize() async {
    try {
      // Ensure Flutter binding is initialized
      WidgetsFlutterBinding.ensureInitialized();

      // Initialize Hive database
      await HiveService.initializeHive();

      return true;
    } on Exception catch (e) {
      // Log error in production apps
      debugPrint('App initialization failed: $e');
      return false;
    }
  }
}
