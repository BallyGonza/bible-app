import 'package:bible_app/blocs/blocs.dart';
import 'package:bible_app/data/data.dart';
import 'package:bloc/bloc.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  NotesBloc() : super(const NotesState.initial()) {
    on<NotesInitialEvent>(_onInit);
    on<NotesAddNoteEvent>(_onAddNote);
    on<NotesAddVerseEvent>(_onAddVerse);
    on<NotesEditNoteEvent>(_onEditNote);
    on<NotesRemoveVerseEvent>(_onRemoveVerse);
    on<NotesDeleteNoteEvent>(_onDeleteNote);

    add(const NotesInitialEvent());
  }

  late UserModel user;
  late List<NoteModel> notes;
  final UserRepository _userRepository = UserRepository();

  Future<void> _onInit(
    NotesInitialEvent event,
    Emitter<NotesState> emit,
  ) async {
    emit(const NotesState.loading());
    user = await _userRepository.getUser();
    notes = user.notes;
    emit(NotesState.loaded(notes));
  }

  Future<void> _onAddNote(
    NotesAddNoteEvent event,
    Emitter<NotesState> emit,
  ) async {
    emit(const NotesState.loading());

    notes.add(event.note);
    await _userRepository.saveUser(user);
    emit(NotesState.loaded(notes));
  }

  Future<void> _onEditNote(
    NotesEditNoteEvent event,
    Emitter<NotesState> emit,
  ) async {
    emit(const NotesState.loading());

    notes[event.index] = event.note;
    await _userRepository.saveUser(user);
    emit(NotesState.loaded(notes));
  }

  Future<void> _onDeleteNote(
    NotesDeleteNoteEvent event,
    Emitter<NotesState> emit,
  ) async {
    emit(const NotesState.loading());
    notes.removeAt(event.index);
    await _userRepository.saveUser(user);
    emit(NotesState.loaded(notes));
  }

  Future<void> _onAddVerse(
    NotesAddVerseEvent event,
    Emitter<NotesState> emit,
  ) async {
    emit(const NotesState.loading());
    notes[event.index].verses.add(event.verse);
    await _userRepository.saveUser(user);
    emit(NotesState.loaded(notes));
  }

  Future<void> _onRemoveVerse(
    NotesRemoveVerseEvent event,
    Emitter<NotesState> emit,
  ) async {
    emit(const NotesState.loading());
    notes[event.index].verses.removeAt(event.verseIndex);
    await _userRepository.saveUser(user);
    emit(NotesState.loaded(notes));
  }
}
