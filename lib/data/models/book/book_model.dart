import 'package:bible_app/data/data.dart';
import 'package:hive/hive.dart';

part 'book_model.g.dart';

@HiveType(typeId: 2)
class BookModel extends HiveObject {
  BookModel({
    required this.id,
    required this.title,
    required this.chapters,
  });

  @HiveField(0)
  int id;
  @HiveField(1)
  String title;
  @HiveField(2)
  List<ChapterModel> chapters;
}
