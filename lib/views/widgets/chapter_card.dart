import 'package:bible_app/data/data.dart';
import 'package:bible_app/views/views.dart';
import 'package:flutter/material.dart';

class ChapterCard extends StatelessWidget {
  const ChapterCard({
    required this.book,
    required this.index,
    super.key,
  });

  final BookModel book;
  final int index;

  @override
  Widget build(BuildContext context) {
    // Add bounds checking for safety
    if (index < 0 || index >= book.chapters.length) {
      return const SizedBox.shrink(); // Return empty widget for invalid indices
    }

    final chapter = book.chapters[index];

    return Semantics(
      button: true,
      label: 'Capítulo ${index + 1}',
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute<ReadingScreen>(
              builder: (context) => ReadingScreen(
                chapter: chapter,
                book: book,
              ),
            ),
          );
        },
        child: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(8),
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
              '${index + 1}',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
