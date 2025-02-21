import 'package:bible_app/data/data.dart';
import 'package:bible_app/views/views.dart';
import 'package:flutter/material.dart';

class ChapterSelectScreen extends StatelessWidget {
  const ChapterSelectScreen({required this.book, super.key});

  final BookModel book;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: appColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: appColorDarker,
            expandedHeight: 150,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              // color gray as background
              background: Container(
                color: appColor,
              ),
              titlePadding: const EdgeInsets.only(
                left: 50,
                bottom: 13,
              ),
              title: Text(
                book.name,
                style: const TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.only(
              bottom: mediaQuery.padding.bottom + 10,
              left: 10,
              right: 10,
            ),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return ChapterCard(book: book, index: index);
                },
                childCount: book.chapters.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
