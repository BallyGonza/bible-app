import 'package:bible_app/data/data.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'notes_event.freezed.dart';

@freezed
class NotesEvent with _$NotesEvent {
  const factory NotesEvent.init() = NotesInitialEvent;
  const factory NotesEvent.addNote(
    NoteModel note,
  ) = NotesAddNoteEvent;
  const factory NotesEvent.editNote(
    int index,
    NoteModel note,
  ) = NotesEditNoteEvent;
  const factory NotesEvent.deleteNote(
    int index,
  ) = NotesDeleteNoteEvent;
  const factory NotesEvent.addVerse(
    int index,
    VerseModel verse,
  ) = NotesAddVerseEvent;
  const factory NotesEvent.removeVerse(
    int index,
    int verseIndex,
  ) = NotesRemoveVerseEvent;
}
