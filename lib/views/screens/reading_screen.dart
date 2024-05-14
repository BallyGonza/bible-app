// ignore_for_file: lines_longer_than_80_chars

import 'package:bible_app/data/data.dart';
import 'package:bible_app/views/views.dart';
import 'package:flutter/material.dart';

class ReadingScreen extends StatefulWidget {
  const ReadingScreen({
    required this.chapter,
    super.key,
  });

  final ChapterModel chapter;

  @override
  State<ReadingScreen> createState() => _ReadingScreenState();
}

class _ReadingScreenState extends State<ReadingScreen> {
  final _sc = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColor,
      body: CustomScrollView(
        controller: _sc,
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
                '${widget.chapter.verses[0].book} ${widget.chapter.number}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final verse = widget.chapter.verses[index];
                return ReadingVerseCard(verse: verse);
              },
              childCount: widget.chapter.verses.length,
            ),
          ),
        ],
      ),
    );
  }
}
