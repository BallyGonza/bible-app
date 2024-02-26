import 'package:bible_app/data/data.dart';
import 'package:hive/hive.dart';

part 'bible_model.g.dart';

@HiveType(typeId: 1)
class BibleModel extends HiveObject {
  BibleModel({
    required this.id,
    required this.name,
    required this.version,
    required this.books,
  });

  @HiveField(0)
  int id;
  @HiveField(1)
  String name;
  @HiveField(2)
  String version;
  @HiveField(3)
  List<BookModel> books;
}
