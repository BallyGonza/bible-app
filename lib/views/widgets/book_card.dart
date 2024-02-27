import 'package:bible_app/data/data.dart';
import 'package:bible_app/views/views.dart';
import 'package:flutter/material.dart';

class BookCard extends StatefulWidget {
  const BookCard({required this.book, super.key});

  final BookModel book;

  @override
  State<BookCard> createState() => _BookCardState();
}

class _BookCardState extends State<BookCard> with TickerProviderStateMixin {
  bool isExpanded = false;
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
    return Card(
      color: appColorDarker,
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              setState(() {
                isExpanded = !isExpanded;
                isExpanded ? _controller.forward() : _controller.reverse();
              });
            },
            child: ListTile(
              title: Text(
                widget.book.name,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
              ),
            ),
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 300),
            curve: Curves.fastOutSlowIn,
            child: SizeTransition(
              sizeFactor: _controller,
              child: Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: Column(
                  children: [
                    for (final chapter in widget.book.chapters)
                      ChapterCard(chapter: chapter),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
