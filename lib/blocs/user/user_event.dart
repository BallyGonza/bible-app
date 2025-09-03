import 'package:bible_app/data/data.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_event.freezed.dart';

/// Events for user-related operations in the Bible app
@freezed
class UserEvent with _$UserEvent {
  /// Initialize user data from repository
  const factory UserEvent.init() = UserInitialEvent;
  
  /// Save or update a verse with color/note modifications
  const factory UserEvent.saveVerse({
    required VerseModel verse,
  }) = UserSaveEvent;
}
