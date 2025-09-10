import 'package:bible_app/data/data.dart';
import 'package:bible_app/views/views.dart';
import 'package:flutter/material.dart';

/// Callback type for chapter selection
typedef OnChapterSelected = void Function(ChapterModel chapter);

class BookCard extends StatefulWidget {
  const BookCard({
    required this.book,
    required this.onChapterSelected,
    super.key,
  });

  final BookModel book;
  final OnChapterSelected onChapterSelected;

  @override
  State<BookCard> createState() => _BookCardState();
}

class _BookCardState extends State<BookCard>
    with SingleTickerProviderStateMixin {
  // Animation constants
  static const Duration _animationDuration = Duration(milliseconds: 200);
  static const Curve _animationCurve = Curves.easeIn;

  static const EdgeInsets _headerPadding =
      EdgeInsets.symmetric(horizontal: 16, vertical: 16);
  static const EdgeInsets _gridPadding =
      EdgeInsets.symmetric(horizontal: 16, vertical: 16);
  static const double _cardBorderRadius = 12.0;
  static const int _gridCrossAxisCount = 7;
  static const double _gridSpacing = 8.0;

  late AnimationController _controller;
  late Animation<double> _heightFactor;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: _animationDuration,
      vsync: this,
    );
    _heightFactor = _controller.drive(CurveTween(curve: _animationCurve));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() {
    setState(() {
      _isExpanded = !_isExpanded;
    });

    if (_isExpanded) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  void _handleChapterTap(ChapterModel chapter) {
    widget.onChapterSelected(chapter);
    if (_isExpanded) {
      _controller.reverse();
      setState(() {
        _isExpanded = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _BookCardHeader(
              bookName: widget.book.name,
              isExpanded: _isExpanded,
              onTap: _handleTap,
            ),
            _ExpandableChapterGrid(
              chapters: widget.book.chapters,
              controller: _controller,
              heightFactor: _heightFactor,
              onChapterTap: _handleChapterTap,
            ),
          ],
        ),
      ),
    );
  }
}

/// Header widget for the book card
class _BookCardHeader extends StatelessWidget {
  const _BookCardHeader({
    required this.bookName,
    required this.isExpanded,
    required this.onTap,
  });

  final String bookName;
  final bool isExpanded;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      hint: isExpanded ? 'Collapse chapters' : 'Expand to see chapters',
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(_BookCardState._cardBorderRadius),
        child: Padding(
          padding: _BookCardState._headerPadding,
          child: Row(
            children: [
              Expanded(
                child: Text(
                  bookName,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                ),
              ),
              AnimatedRotation(
                turns: isExpanded ? 0.5 : 0.0,
                duration: _BookCardState._animationDuration,
                child: Icon(
                  Icons.keyboard_arrow_down,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Expandable grid widget for chapters
class _ExpandableChapterGrid extends StatelessWidget {
  const _ExpandableChapterGrid({
    required this.chapters,
    required this.controller,
    required this.heightFactor,
    required this.onChapterTap,
  });

  final List<ChapterModel> chapters;
  final AnimationController controller;
  final Animation<double> heightFactor;
  final void Function(ChapterModel) onChapterTap;

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          return Align(
            alignment: Alignment.topCenter,
            heightFactor: heightFactor.value,
            child: child,
          );
        },
        child: _ChapterGrid(
          chapters: chapters,
          onChapterTap: onChapterTap,
        ),
      ),
    );
  }
}

/// Grid widget for displaying chapters
class _ChapterGrid extends StatelessWidget {
  const _ChapterGrid({
    required this.chapters,
    required this.onChapterTap,
  });

  final List<ChapterModel> chapters;
  final void Function(ChapterModel) onChapterTap;

  @override
  Widget build(BuildContext context) {
    // Use GridView for many chapters
    return GridView.builder(
      padding: _BookCardState._gridPadding,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: _BookCardState._gridCrossAxisCount,
        crossAxisSpacing: _BookCardState._gridSpacing,
        mainAxisSpacing: _BookCardState._gridSpacing,
      ),
      itemCount: chapters.length,
      itemBuilder: (context, index) {
        final chapter = chapters[index];
        return _ChapterButton(
          key: ValueKey(chapter.number), // Use chapter number for key
          chapter: chapter,
          onTap: (chapter) => onChapterTap(chapter),
        );
      },
    );
  }
}

/// Individual chapter button widget
class _ChapterButton extends StatelessWidget {
  const _ChapterButton({
    super.key, // Add key parameter
    required this.chapter,
    required this.onTap,
  });

  final ChapterModel chapter;
  final void Function(ChapterModel) onTap;

  @override
  Widget build(BuildContext context) {
    return NumberButton(
      number: chapter.number,
      onTap: () => onTap(chapter),
    );
  }
}
