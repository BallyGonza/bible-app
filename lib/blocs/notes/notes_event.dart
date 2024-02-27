import 'package:bible_app/data/data.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'notes_event.freezed.dart';

@freezed
class NotesEvent with _$NotesEvent {
  const factory NotesEvent.init() = NotesInitialEvent;
  const factory NotesEvent.add(
    NoteModel note,
  ) = NotesAddEvent;
  const factory NotesEvent.edit(
    int index,
    NoteModel note,
  ) = NotesEditEvent;
  const factory NotesEvent.delete(
    int index,
  ) = NotesDeleteEvent;
  const factory NotesEvent.deleteAll(
    List<NoteModel> notes,
  ) = NotesDeleteAllEvent;
}
