import 'package:bible_app/data/data.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'notes_state.freezed.dart';

@freezed
class NotesState with _$NotesState {
  const factory NotesState.initial() = NotesInitial;
  const factory NotesState.loading() = NotesLoading;
  const factory NotesState.loaded(List<NoteModel> notes) = NotesLoaded;
  const factory NotesState.failure() = NotesFailure;
}
