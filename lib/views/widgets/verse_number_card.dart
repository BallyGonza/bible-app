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
  late Color _verseColor;
  late Color _verseTextColor;
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool _colorsInitialized = false;

  @override
  void initState() {
    super.initState();
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
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_colorsInitialized) {
      _initializeColors();
      _colorsInitialized = true;
    }
  }

  void _initializeColors() {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    _verseColor = widget.verse.color != null
        ? Color(widget.verse.color!)
        : colorScheme.secondaryContainer;

    _verseTextColor = _verseColor.computeLuminance() > 0.5
        ? colorScheme.onSecondaryContainer
        : colorScheme.onSecondaryContainer;
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
            color: _verseColor,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).colorScheme.shadow.withOpacity(0.1),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Center(
            child: Text(
              widget.verse.number.toString(),
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: _verseTextColor,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
