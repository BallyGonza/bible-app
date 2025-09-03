import 'package:bible_app/blocs/blocs.dart';
import 'package:bible_app/data/data.dart';
import 'package:bible_app/views/views.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VerseSelectScreen extends StatelessWidget {
  const VerseSelectScreen({required this.chapterNumber, super.key});

  final int chapterNumber;

  // Layout constants
  static const double _appBarExpandedHeight = 150.0;
  static const EdgeInsets _titlePadding = EdgeInsets.only(left: 50, bottom: 13);
  static const EdgeInsets _gridPadding = EdgeInsets.all(10.0);
  static const int _gridCrossAxisCount = 5;
  static const double _titleFontSize = 24.0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, userState) {
        return userState.maybeWhen(
          orElse: () => const _LoadingState(),
          loaded: (user) {
            final chapter = user.bible.books
                .firstWhere(
                  (book) => book.chapters.any(
                    (chapter) => chapter.number == chapterNumber,
                  ),
                )
                .chapters
                .firstWhere(
                  (chapter) => chapter.number == chapterNumber,
                );
            return _VerseSelectContent(
              chapter: chapter,
              appBarExpandedHeight: _appBarExpandedHeight,
              titlePadding: _titlePadding,
              titleFontSize: _titleFontSize,
              gridPadding: _gridPadding,
              gridCrossAxisCount: _gridCrossAxisCount,
            );
          },
          error: (message) => _ErrorState(message: message),
        );
      },
    );
  }
}

/// Loading state widget
class _LoadingState extends StatelessWidget {
  const _LoadingState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

/// Error state widget
class _ErrorState extends StatelessWidget {
  const _ErrorState({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.red[400],
            ),
            const SizedBox(height: 16),
            Text(
              'Something went wrong',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.red[600],
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              message,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[600],
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

/// Main content widget when user is loaded
class _VerseSelectContent extends StatelessWidget {
  const _VerseSelectContent({
    required this.chapter,
    required this.appBarExpandedHeight,
    required this.titlePadding,
    required this.titleFontSize,
    required this.gridPadding,
    required this.gridCrossAxisCount,
  });

  final ChapterModel chapter;
  final double appBarExpandedHeight;
  final EdgeInsets titlePadding;
  final double titleFontSize;
  final EdgeInsets gridPadding;
  final int gridCrossAxisCount;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: CustomScrollView(
        slivers: [
          _VerseSelectAppBar(
            chapter: chapter,
            expandedHeight: appBarExpandedHeight,
            titlePadding: titlePadding,
            titleFontSize: titleFontSize,
          ),
          _VerseGrid(
            chapter: chapter,
            padding: gridPadding,
            crossAxisCount: gridCrossAxisCount,
          ),
        ],
      ),
    );
  }
}

/// Custom app bar for verse selection screen
class _VerseSelectAppBar extends StatelessWidget {
  const _VerseSelectAppBar({
    required this.chapter,
    required this.expandedHeight,
    required this.titlePadding,
    required this.titleFontSize,
  });

  final ChapterModel chapter;

  final double expandedHeight;
  final EdgeInsets titlePadding;
  final double titleFontSize;

  String get _chapterTitle {
    if (chapter.verses.isEmpty) {
      return 'Chapter ${chapter.number}';
    }
    return '${chapter.verses.first.book} ${chapter.number}';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SliverAppBar(
      backgroundColor: theme.appBarTheme.backgroundColor,
      expandedHeight: expandedHeight,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          color: theme.scaffoldBackgroundColor,
        ),
        titlePadding: titlePadding,
        title: Text(
          _chapterTitle,
          style: theme.appBarTheme.titleTextStyle?.copyWith(
                fontSize: titleFontSize,
              ) ??
              TextStyle(
                fontSize: titleFontSize,
                color: theme.colorScheme.onPrimary,
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
    );
  }
}

/// Grid widget for displaying verse numbers
class _VerseGrid extends StatelessWidget {
  const _VerseGrid({
    required this.chapter,
    required this.padding,
    required this.crossAxisCount,
  });

  final ChapterModel chapter;

  final EdgeInsets padding;
  final int crossAxisCount;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return SliverPadding(
      padding: padding.copyWith(
        bottom: mediaQuery.padding.bottom + padding.bottom,
      ),
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return VerseNumberCard(
              chapter: chapter,
              verse: chapter.verses[index],
            );
          },
          childCount: chapter.verses.length,
        ),
      ),
    );
  }
}
