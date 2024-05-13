import 'package:hive/hive.dart';

part 'verse_note_model.g.dart';

@HiveType(typeId: 6)
class VerseNoteModel extends HiveObject {
  VerseNoteModel({
    required this.content,
  });

  @HiveField(0)
  String content;

  VerseNoteModel copyWith({
    String? content,
  }) {
    return VerseNoteModel(
      content: content ?? this.content,
    );
  }
}
