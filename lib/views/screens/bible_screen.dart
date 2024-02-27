import 'package:bible_app/data/data.dart';
import 'package:bible_app/views/widgets/widgets.dart';
import 'package:flutter/material.dart';

class BibleScreen extends StatelessWidget {
  const BibleScreen({required this.user, super.key});

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: user.bible.books.length,
      itemBuilder: (context, index) {
        final book = user.bible.books[index];
        return BookCard(
          book: book,
        );
      },
    );
  }
}
