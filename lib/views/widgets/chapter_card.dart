// ignore_for_file: lines_longer_than_80_chars

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
  VerseModel? selectedVerse;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
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
              '${widget.chapter.number}',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
            ),
            title: Text(
              widget.chapter.name,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Colors.white,
                  ),
            ),
          ),
        ),
        AnimatedSize(
          duration: const Duration(milliseconds: 300),
          curve: Curves.ease,
          child: SizeTransition(
            sizeFactor: _controller,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Center(
                child: Wrap(
                  children: [
                    for (final verse in widget.chapter.verses)
                      InkWell(
                        onTap: () {
                          setState(() {
                            selectedVerse == verse
                                ? selectedVerse = null
                                : selectedVerse = verse;
                          });
                          showModalBottomSheet<Container>(
                            backgroundColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(11),
                            ),
                            context: context,
                            builder: (context) => Container(
                              padding: const EdgeInsets.all(8),
                              decoration: const BoxDecoration(
                                color: appColor,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                ),
                              ),
                              height: verse.text.length > 100 ? 205 : 155,
                              child: ListTile(
                                subtitle: Text(
                                  '${verse.book} ${widget.chapter.number}:${verse.number}',
                                  textAlign: TextAlign.right,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                        color: Colors.white,
                                      ),
                                ),
                                title: Text(
                                  verse.text,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(
                                        color: Colors.white,
                                      ),
                                ),
                              ),
                            ),
                          );
                        },
                        onLongPress: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute<ReadingScreen>(
                              builder: (context) => ReadingScreen(
                                chapter: widget.chapter,
                                verse: verse,
                              ),
                            ),
                          );
                          setState(() {
                            selectedVerse = null;
                            _controller.reverse();
                          });
                        },
                        child: VerseCard(
                          isSelected: selectedVerse == verse,
                          verse: verse,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
