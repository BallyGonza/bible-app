import 'package:bible_app/data/data.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveService {
  // Private constructor to prevent instantiation
  HiveService._();

  // Box names constants
  static const String _usersBoxName = 'users_box';

  /// Initializes Hive with all necessary adapters and opens required boxes
  static Future<void> initializeHive() async {
    // Register all model adapters
    _registerAdapters();

    // Initialize Hive for Flutter
    await Hive.initFlutter();

    // Open all required boxes
    await _openBoxes();

    if (kDebugMode) {
      print('Hive initialized successfully');
    }
  }

  /// Registers all Hive type adapters
  static void _registerAdapters() {
    Hive
      ..registerAdapter(UserModelAdapter())
      ..registerAdapter(BibleModelAdapter())
      ..registerAdapter(BookModelAdapter())
      ..registerAdapter(ChapterModelAdapter())
      ..registerAdapter(VerseModelAdapter())
      ..registerAdapter(VerseNoteModelAdapter())
      ..registerAdapter(NoteModelAdapter());
  }

  /// Opens all required Hive boxes
  static Future<void> _openBoxes() async {
    await Future.wait([
      Hive.openBox<UserModel>(_usersBoxName),
    ]);
  }

  /// Gets the users box
  static Box<UserModel> get usersBox => Hive.box<UserModel>(_usersBoxName);

  /// Closes all Hive boxes and cleans up resources
  static Future<void> dispose() async {
    await Hive.close();
    if (kDebugMode) {
      print('Hive disposed successfully');
    }
  }

  /// Clears all data from a specific box
  static Future<void> clearBox<T>(String boxName) async {
    final box = Hive.box<T>(boxName);
    await box.clear();
    if (kDebugMode) {
      print('Cleared box: $boxName');
    }
  }

  /// Checks if Hive is initialized
  static bool get isInitialized => Hive.isBoxOpen(_usersBoxName);
}
