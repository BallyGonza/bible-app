import 'package:bible_app/data/data.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveService {
  // This function initializes Hive and opens the necessary boxes.
  static Future<void> initializeHive() async {
    try {
      // Registering the UserModelAdapter to serialize/deserialize UserModel objects.
      Hive
        ..registerAdapter(UserModelAdapter())
        ..registerAdapter(BibleModelAdapter())
        ..registerAdapter(BookModelAdapter())
        ..registerAdapter(ChapterModelAdapter())
        ..registerAdapter(VerseModelAdapter())
        ..registerAdapter(VerseNoteModelAdapter())
        ..registerAdapter(NoteModelAdapter());
      WidgetsFlutterBinding.ensureInitialized();
      await Hive.initFlutter();
      // Opening a box to store UserModel objects.
      await Hive.openBox<UserModel>('users_box');
    } catch (e) {
      if (kDebugMode) {
        print('Failed to initialize Hive: $e');
      }
    }
  }
}
