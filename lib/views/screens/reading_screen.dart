// ignore_for_file: lines_longer_than_80_chars

import 'package:bible_app/data/data.dart';
import 'package:bible_app/views/views.dart';
import 'package:flutter/material.dart';

class ReadingScreen extends StatefulWidget {
  const ReadingScreen({
    required this.chapter,
    required this.verse,
    super.key,
  });

  final ChapterModel chapter;
  final VerseModel verse;

  @override
  State<ReadingScreen> createState() => _ReadingScreenState();
}

class _ReadingScreenState extends State<ReadingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColor,
      appBar: AppBar(
        title: FittedBox(
          fit: BoxFit.fitWidth,
          child: Text(
            '${widget.chapter.number} ${widget.verse.book}: ${widget.chapter.name}',
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Center(
          child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemCount: widget.chapter.verses.length,
            separatorBuilder: (context, index) => const Divider(
              height: 3,
            ),
            itemBuilder: (context, index) {
              final verse = widget.chapter.verses[index];
              return ReadingVerseCard(verse: verse);
            },
          ),
        ),
      ),
    );
  }
}
