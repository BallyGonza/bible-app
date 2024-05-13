import 'package:bible_app/data/data.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'verse_model.g.dart';

@HiveType(typeId: 4)
class VerseModel extends HiveObject {
  VerseModel({
    required this.number,
    required this.book,
    required this.chapter,
    required this.text,
    this.note,
    this.color,
  });

  @HiveField(0)
  int number;
  @HiveField(1)
  String book;
  @HiveField(2)
  int chapter;
  @HiveField(3)
  String text;
  @HiveField(4)
  VerseNoteModel? note;
  @HiveField(5)
  int? color = Colors.transparent.value;

  VerseModel copyWith({
    int? number,
    String? book,
    int? chapter,
    String? text,
    VerseNoteModel? note,
    int? color,
  }) {
    return VerseModel(
      number: number ?? this.number,
      book: book ?? this.book,
      chapter: chapter ?? this.chapter,
      text: text ?? this.text,
      note: note ?? this.note,
      color: color ?? this.color,
    );
  }
}
