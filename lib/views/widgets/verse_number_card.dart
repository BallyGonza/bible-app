import 'package:bible_app/data/data.dart';
import 'package:bible_app/views/views.dart';
import 'package:flutter/material.dart';

class VerseNumberCard extends StatefulWidget {
  const VerseNumberCard({
    required this.chapter,
    required this.verse,
    super.key,
  });

  final ChapterModel chapter;
  final VerseModel verse;

  @override
  State<VerseNumberCard> createState() => _VerseNumberCardState();
}

class _VerseNumberCardState extends State<VerseNumberCard>
    with SingleTickerProviderStateMixin {
  late int verseColor;
  late int verseTextColor;
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    verseColor = widget.verse.color ?? appColorDarker.value;
    verseTextColor = Color(verseColor).computeLuminance() > 0.5
        ? Colors.black.value
        : Colors.white.value;

    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ReadingScreen(
              chapter: widget.chapter,
              verse: widget.verse,
            ),
          ),
        );
      },
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) => _controller.reverse(),
      onTapCancel: () => _controller.reverse(),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: child,
          );
        },
        child: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Color(verseColor),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(
              widget.verse.number.toString(),
              style: Theme.of(context).textTheme.displayMedium!.copyWith(
                    color: Color(verseTextColor),
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
