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
  });
  @HiveField(0)
  final int id;
  @HiveField(1)
  String title;
  @HiveField(2)
  String content;
  @HiveField(3)
  List<VerseModel> verses;
  @HiveField(4)
  String date;
  @HiveField(5)
  int color;
}
