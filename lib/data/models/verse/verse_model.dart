import 'package:hive/hive.dart';

part 'verse_model.g.dart';

@HiveType(typeId: 1)
class VerseModel extends HiveObject {
  VerseModel({
    required this.id,
    required this.book,
    required this.chapter,
    required this.verse,
    this.color,
    this.note,
  });

  @HiveField(0)
  int id;
  @HiveField(1)
  String book;
  @HiveField(2)
  int chapter;
  @HiveField(3)
  int verse;
  @HiveField(4)
  String? color;
  @HiveField(5)
  String? note;
}
