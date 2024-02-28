import 'package:bible_app/data/data.dart';
import 'package:hive/hive.dart';

part 'chapter_model.g.dart';

@HiveType(typeId: 3)
class ChapterModel extends HiveObject {
  ChapterModel({
    required this.number,
    required this.verses,
  });

  @HiveField(0)
  int number;
  @HiveField(1)
  List<VerseModel> verses;
}
