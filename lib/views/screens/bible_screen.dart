import 'package:bible_app/blocs/blocs.dart';
import 'package:bible_app/data/data.dart';
import 'package:bible_app/views/views.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BibleScreen extends StatefulWidget {
  const BibleScreen({required this.user, super.key});

  final UserModel user;

  @override
  State<BibleScreen> createState() => _BibleScreenState();
}

class _BibleScreenState extends State<BibleScreen> {
  // Constants for better maintainability
  static const double _appBarExpandedHeight = 150.0;

  @override
  void initState() {
    super.initState();
    _initializeBloc();
  }

  void _initializeBloc() {
    context.read<SearchBarBookBloc>().add(
          SearchBarBookEvent.init(widget.user),
        );
  }

  void _onSearchChanged(String value) {
    context.read<SearchBarBookBloc>().add(
          SearchBarBookEvent.search(
            widget.user.bible,
            value,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _BibleAppBar(onSearchChanged: _onSearchChanged),
          _BibleBookList(),
        ],
      ),
    );
  }
}

class _BibleAppBar extends StatelessWidget {
  const _BibleAppBar({required this.onSearchChanged});

  final ValueChanged<String> onSearchChanged;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
      surfaceTintColor: Theme.of(context).colorScheme.surfaceTint,
      expandedHeight: _BibleScreenState._appBarExpandedHeight,
      pinned: true,
      elevation: 0,
      shadowColor: Theme.of(context).colorScheme.shadow.withOpacity(0.1),
      flexibleSpace: FlexibleSpaceBar(
        background: _AppBarBackground(onSearchChanged: onSearchChanged),
        titlePadding: const EdgeInsets.only(left: 20, bottom: 16),
        centerTitle: false,
        title: Text(
          'Biblia',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.onSurface,
              ),
        ),
      ),
    );
  }
}

class _AppBarBackground extends StatelessWidget {
  const _AppBarBackground({required this.onSearchChanged});

  final ValueChanged<String> onSearchChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _BibleSearchBar(onChanged: onSearchChanged),
      ],
    );
  }
}

class _BibleSearchBar extends StatefulWidget {
  const _BibleSearchBar({required this.onChanged});

  final ValueChanged<String> onChanged;

  @override
  State<_BibleSearchBar> createState() => _BibleSearchBarState();
}

class _BibleSearchBarState extends State<_BibleSearchBar> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomSearchBar(
      hintText: 'Buscar libros...',
      onChanged: widget.onChanged,
      controller: _controller,
      focusNode: _focusNode,
    );
  }
}

class _BibleBookList extends StatelessWidget {
  const _BibleBookList();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBarBookBloc, SearchBarBookState>(
      builder: (context, state) {
        return state.maybeWhen(
          orElse: () => const _LoadingState(),
          loaded: (books) =>
              books.isEmpty ? const _EmptyState() : _LoadedState(books: books),
          error: (message) => _ErrorState(message: message),
        );
      },
    );
  }
}

class _LoadingState extends StatelessWidget {
  const _LoadingState();

  @override
  Widget build(BuildContext context) {
    return const SliverFillRemaining(
      child: Center(child: CircularProgressIndicator()),
    );
  }
}

class _LoadedState extends StatelessWidget {
  const _LoadedState({required this.books});

  final List<BookModel> books;

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemCount: books.length,
      itemBuilder: (context, index) {
        final book = books[index];
        return BookCard(
          book: book,
          onChapterSelected: (chapter) {
            // Find the chapter in the current book to ensure we have the correct reference
            final selectedChapter = book.chapters.firstWhere(
              (c) => c.number == chapter.number,
              orElse: () => chapter,
            );

            Navigator.push(
              context,
              MaterialPageRoute<VerseSelectScreen>(
                builder: (context) =>
                    VerseSelectScreen(chapter: selectedChapter),
              ),
            );
          },
        );
      },
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off,
              size: 64,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              'No books found',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.grey[600],
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              'Try adjusting your search terms',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[500],
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  const _ErrorState({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      child: Center(
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
