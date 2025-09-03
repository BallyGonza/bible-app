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
  UserModel? _user;

  /// [_onInit] is triggered when a [UserInitialEvent] is added to the bloc.
  /// It fetches the user from the repository and emits a new state.
  Future<void> _onInit(
    UserInitialEvent event,
    Emitter<UserState> emit,
  ) async {
    emit(const UserState.loading());
    try {
      _user = await _userRepository.getUser();
      emit(UserState.loaded(_user!));
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
      final updatedVerse = _findAndUpdateVerse(_user!, event.verse);

      if (updatedVerse != null) {
        await _userRepository.saveUser(_user!);
        emit(UserState.loaded(_user!));
      } else {
        emit(const UserState.error('Verse not found'));
      }
    } catch (e) {
      emit(UserState.error(e.toString()));
    }
  }

  /// Finds and updates a verse using efficient lookup by book, chapter, and number
  /// Returns the updated verse if found, null otherwise
  VerseModel? _findAndUpdateVerse(UserModel user, VerseModel targetVerse) {
    // Direct lookup using book name - O(n) instead of O(n³)
    final targetBook = user.bible.books
        .where((book) => book.name == targetVerse.book)
        .firstOrNull;

    if (targetBook == null) return null;

    // Direct lookup using chapter number
    final targetChapter = targetBook.chapters
        .where((chapter) => chapter.number == targetVerse.chapter)
        .firstOrNull;

    if (targetChapter == null) return null;

    // Direct lookup using verse number - more reliable than text comparison
    final verseToUpdate = targetChapter.verses
        .where((verse) => verse.number == targetVerse.number)
        .firstOrNull;

    if (verseToUpdate != null) {
      _updateVerseProperties(verseToUpdate, targetVerse);
      return verseToUpdate;
    }

    return null;
  }

  /// Updates verse properties following immutability principles
  void _updateVerseProperties(VerseModel target, VerseModel source) {
    if (source.color != null) {
      target.color = source.color;
    }
    if (source.note != null) {
      target.note = source.note;
    }
  }
}
