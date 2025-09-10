import 'package:bible_app/data/data.dart';
import 'package:bible_app/views/views.dart';
import 'package:flutter/material.dart';

class VerseNumberCard extends StatefulWidget {
  const VerseNumberCard({
    required this.book,
    required this.chapter,
    required this.verse,
    super.key,
  });

  final BookModel book;
  final ChapterModel chapter;
  final VerseModel verse;

  @override
  State<VerseNumberCard> createState() => _VerseNumberCardState();
}

class _VerseNumberCardState extends State<VerseNumberCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _elevationAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.92).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
        reverseCurve: Curves.easeIn,
      ),
    );

    _elevationAnimation = Tween<double>(begin: 0.0, end: 8.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Calculate colors on every build to ensure reactivity
  (Color backgroundColor, Color textColor) _calculateColors(
      BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final backgroundColor = widget.verse.color != null
        ? Color(widget.verse.color!)
        : colorScheme.surfaceContainer;

    // Calculate proper contrast color based on background luminance
    final luminance = backgroundColor.computeLuminance();
    final textColor = luminance > 0.5 ? Colors.black87 : Colors.white;

    return (backgroundColor, textColor);
  }

  @override
  Widget build(BuildContext context) {
    final (backgroundColor, textColor) = _calculateColors(context);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ReadingScreen(
              chapter: widget.chapter,
              verse: widget.verse,
              book: widget.book,
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
            child: Material(
              color: backgroundColor,
              elevation: _elevationAnimation.value,
              borderRadius: BorderRadius.circular(16),
              shadowColor: colorScheme.shadow.withOpacity(0.3),
              child: Container(
                width: 56,
                height: 56,
                alignment: Alignment.center,
                child: Text(
                  widget.verse.number.toString(),
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: textColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
