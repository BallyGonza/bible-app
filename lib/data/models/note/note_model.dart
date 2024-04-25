import 'package:bible_app/data/data.dart';
import 'package:hive/hive.dart';

part 'note_model.g.dart';

@HiveType(typeId: 5)
class NoteModel extends HiveObject {
  NoteModel({
    required this.id,
    required this.title,
    required this.content,
    required this.date,
    required this.color,
    required this.verses,
    this.author,
  });
  @HiveField(0)
  final int id;
  @HiveField(1)
  String title;
  @HiveField(2)
  String? author;
  @HiveField(3)
  String content;
  @HiveField(4)
  List<VerseModel> verses;
  @HiveField(5)
  String date;
  @HiveField(6)
  int color;

  NoteModel copyWith({
    int? id,
    String? title,
    String? author,
    String? content,
    List<VerseModel>? verses,
    String? date,
    int? color,
  }) {
    return NoteModel(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      author: author ?? this.author,
      date: date ?? this.date,
      color: color ?? this.color,
      verses: verses ?? this.verses,
    );
  }
}
