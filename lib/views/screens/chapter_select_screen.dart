import 'package:bible_app/data/data.dart';
import 'package:bible_app/views/views.dart';
import 'package:flutter/material.dart';

class ChapterSelectScreen extends StatelessWidget {
  const ChapterSelectScreen({required this.book, super.key});

  final BookModel book;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColor,
      appBar: AppBar(
        title: Text(book.name),
      ),
      body: GridView.builder(
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5,
        ),
        itemCount: book.chapters.length,
        itemBuilder: (context, index) {
          return ChapterCard(book: book, index: index);
        },
      ),
    );
  }
}
