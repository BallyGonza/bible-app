import 'package:bible_app/blocs/blocs.dart';
import 'package:bible_app/data/data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// [UserBloc] is responsible for managing user related events and states.
class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(const UserState.initial()) {
    on<UserInitialEvent>(_onInit);

    on<UserSaveEvent>(_onSaveVerse);
    add(const UserEvent.init());
  }

  final UserRepository _userRepository;
  late UserModel _user;

  /// [_onInit] is triggered when a [UserInitialEvent] is added to the bloc.
  /// It fetches the user from the repository and emits a new state.
  Future<void> _onInit(
    UserInitialEvent event,
    Emitter<UserState> emit,
  ) async {
    emit(const UserState.loading());
    try {
      _user = await _userRepository.getUser();
      emit(UserState.loaded(_user));
    } catch (e) {
      emit(UserState.error(e.toString()));
    }
  }

  Future<void> _onSaveVerse(
    UserSaveEvent event,
    Emitter<UserState> emit,
  ) async {
    emit(const UserState.loading());
    try {
      for (final book in _user.bible.books) {
        for (final chapter in book.chapters) {
          for (final verse in chapter.verses) {
            if (verse.text == event.verse.text) {
              verse
                ..color = event.verse.color
                ..note = event.verse.note;
            }
          }
        }
      }
      await _userRepository.saveUser(_user);
      emit(UserState.loaded(_user));
    } catch (e) {
      emit(UserState.error(e.toString()));
    }
  }
}
