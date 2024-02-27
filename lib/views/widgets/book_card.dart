import 'package:bible_app/data/data.dart';
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
      duration: const Duration(milliseconds: 500),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(widget.book.name),
        subtitle: Text('Chapters: ${widget.book.chapters.length}'),
        trailing: const Icon(Icons.arrow_forward_ios),
      ),
    );
  }
}
