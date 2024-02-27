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
  int? color = Colors.transparent.value;
}
