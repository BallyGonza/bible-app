import 'package:bible_app/data/data.dart';
import 'package:bible_app/views/views.dart';
import 'package:flutter/material.dart';

class ChapterCard extends StatefulWidget {
  const ChapterCard({required this.chapter, super.key});

  final ChapterModel chapter;

  @override
  State<ChapterCard> createState() => _ChapterCardState();
}

class _ChapterCardState extends State<ChapterCard>
    with TickerProviderStateMixin {
  bool isExpanded = false;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            setState(() {
              isExpanded = !isExpanded;
              isExpanded ? _controller.forward() : _controller.reverse();
            });
          },
          child: ListTile(
            leading: Text(
              widget.chapter.number.toString(),
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            title: Text(
              widget.chapter.name,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            trailing: isExpanded
                ? const Icon(Icons.arrow_drop_up)
                : const Icon(Icons.arrow_drop_down),
          ),
        ),
        AnimatedSize(
          duration: const Duration(milliseconds: 100),
          curve: Curves.fastOutSlowIn,
          child: SizeTransition(
            sizeFactor: _controller,
            child: Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: Wrap(
                children: [
                  for (final verse in widget.chapter.verses)
                    VerseCard(
                      chapter: widget.chapter,
                      verse: verse,
                    ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
