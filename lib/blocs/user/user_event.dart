import 'package:bible_app/data/data.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_event.freezed.dart';

@freezed
class UserEvent with _$UserEvent {
  const factory UserEvent.init() = UserInitialEvent;
  const factory UserEvent.saveVerse({
    required VerseModel verse,
  }) = UserSaveEvent;
}
