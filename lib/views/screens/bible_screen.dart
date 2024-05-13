import 'package:bible_app/data/data.dart';
import 'package:bible_app/views/widgets/widgets.dart';
import 'package:flutter/material.dart';

class BibleScreen extends StatelessWidget {
  const BibleScreen({required this.user, super.key});

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: appColorDarker,
            expandedHeight: 150,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              // color gray as background
              background: Container(
                color: appColorDarker,
              ),
              titlePadding: const EdgeInsets.only(
                left: 16,
                bottom: 16,
              ),
              title: const Text(
                'Bible',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final book = user.bible.books[index];
                return BookCard(
                  book: book,
                );
              },
              childCount: user.bible.books.length,
            ),
          ),
        ],
      ),
    );
  }
}
