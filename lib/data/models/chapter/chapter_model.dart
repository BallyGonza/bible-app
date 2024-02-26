import 'package:bible_app/data/models/verse/verse_model.dart';
import 'package:hive/hive.dart';

part 'chapter_model.g.dart';

@HiveType(typeId: 3)
class ChapterModel extends HiveObject {
  ChapterModel({
    required this.id,
    required this.title,
    required this.verses,
  });

  @HiveField(0)
  int id;
  @HiveField(1)
  String title;
  @HiveField(2)
  List<VerseModel> verses;
}
