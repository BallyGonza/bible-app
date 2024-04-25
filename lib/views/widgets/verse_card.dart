import 'package:bible_app/data/data.dart';
import 'package:flutter/material.dart';

class VerseCard extends StatelessWidget {
  const VerseCard({
    required this.isSelected,
    required this.verse,
    super.key,
  });

  final bool isSelected;
  final VerseModel verse;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      margin: const EdgeInsets.only(right: 5, bottom: 5),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Color(verse.color ?? appColorDarker.value),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isSelected ? accentColor : Colors.transparent,
        ),
      ),
      child: Text(
        verse.number.toString(),
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 16,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
