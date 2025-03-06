import 'package:bible_app/data/data.dart';
import 'package:bible_app/views/views.dart';
import 'package:flutter/material.dart';

class VerseSelectScreen extends StatelessWidget {
  const VerseSelectScreen({required this.chapter, super.key});

  final ChapterModel chapter;

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
                chapter.verses.first.book + ' ' + chapter.number.toString(),
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
                  return VerseNumberCard(
                    chapter: chapter,
                    verse: chapter.verses[index],
                  );
                },
                childCount: chapter.verses.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
