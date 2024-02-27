import 'package:bible_app/data/data.dart';
import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
class UserModel extends HiveObject {
  UserModel({
    required this.id,
    required this.notes,
    required this.bible,
  });

  @HiveField(0)
  int id;
  @HiveField(1)
  List<NoteModel> notes;
  @HiveField(2)
  BibleModel bible;
}
