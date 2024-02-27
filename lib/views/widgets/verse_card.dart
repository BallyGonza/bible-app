import 'package:bible_app/data/data.dart';
import 'package:bible_app/views/views.dart';
import 'package:flutter/material.dart';

class VerseCard extends StatelessWidget {
  const VerseCard({
    required this.chapter,
    required this.verse,
    super.key,
  });

  final ChapterModel chapter;
  final VerseModel verse;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute<ReadingScreen>(
            builder: (context) => ReadingScreen(
              chapter: chapter,
              verse: verse,
            ),
          ),
        );
      },
      child: Container(
        width: 30,
        margin: const EdgeInsets.only(right: 5, bottom: 5),
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          verse.number.toString(),
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
