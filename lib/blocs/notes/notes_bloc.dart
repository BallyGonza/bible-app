import 'package:bible_app/blocs/blocs.dart';
import 'package:bible_app/data/data.dart';
import 'package:bloc/bloc.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  NotesBloc() : super(const NotesState.initial()) {
    on<NotesInitialEvent>(_onInit);
    on<NotesAddEvent>(_onAdd);
    on<NotesEditEvent>(_onEdit);
    on<NotesDeleteEvent>(_onDelete);

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

  Future<void> _onAdd(
    NotesAddEvent event,
    Emitter<NotesState> emit,
  ) async {
    emit(const NotesState.loading());

    notes.add(event.note);
    await _userRepository.saveUser(user);
    emit(NotesState.loaded(notes));
  }

  Future<void> _onEdit(
    NotesEditEvent event,
    Emitter<NotesState> emit,
  ) async {
    emit(const NotesState.loading());

    notes[event.index] = event.note;
    await _userRepository.saveUser(user);
    emit(NotesState.loaded(notes));
  }

  Future<void> _onDelete(
    NotesDeleteEvent event,
    Emitter<NotesState> emit,
  ) async {
    emit(const NotesState.loading());
    notes.removeAt(event.index);
    await _userRepository.saveUser(user);
    emit(NotesState.loaded(notes));
  }
}
