import 'package:bible_app/data/data.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_state.freezed.dart';

/// States for user data management in the Bible app
@freezed
class UserState with _$UserState {
  /// Initial state before any data is loaded
  const factory UserState.initial() = UserInitialState;
  
  /// Loading state while fetching user data
  const factory UserState.loading() = UserLoadingState;
  
  /// Successfully loaded user data with Bible content
  const factory UserState.loaded(UserModel user) = UserLoadedState;
  
  /// Error state with descriptive message
  const factory UserState.error(String message) = UserErrorState;
}
