import 'package:bible_app/data/data.dart';
import 'package:bible_app/views/views.dart';
import 'package:flutter/material.dart';

class BookCard extends StatelessWidget {
  const BookCard({
    required this.book,
    super.key,
  });

  final BookModel book;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      child: Card(
        color: appColorDarker,
        child: Column(
          children: <Widget>[
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<ChapterSelectScreen>(
                    builder: (context) => ChapterSelectScreen(
                      book: book,
                    ),
                  ),
                );
              },
              child: ListTile(
                title: Text(
                  book.name,
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(),
                ),
                //!TODO: Add description to book
              ),
            ),
          ],
        ),
      ),
    );
  }
}
