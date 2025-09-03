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
  static const double _appBarExpandedHeight = 200.0;
  static const double _titleFontSize = 24.0;
  static const EdgeInsets _titlePadding = EdgeInsets.only(left: 16, bottom: 16);
  static const EdgeInsets _searchBarMargin =
      EdgeInsets.symmetric(horizontal: 20);

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
          _BibleAppBar(
            onSearchChanged: _onSearchChanged,
          ),
          _BibleBookList(),
        ],
      ),
    );
  }
}

class _BibleAppBar extends StatelessWidget {
  const _BibleAppBar({
    required this.onSearchChanged,
  });

  final ValueChanged<String> onSearchChanged;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: appColorDarker,
      expandedHeight: _BibleScreenState._appBarExpandedHeight,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        background: _AppBarBackground(onSearchChanged: onSearchChanged),
        titlePadding: _BibleScreenState._titlePadding,
        title: const _AppBarTitle(),
      ),
    );
  }
}

class _AppBarBackground extends StatelessWidget {
  const _AppBarBackground({
    required this.onSearchChanged,
  });

  final ValueChanged<String> onSearchChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 10),
        _BibleSearchBar(onChanged: onSearchChanged),
        SizedBox(height: MediaQuery.of(context).padding.top),
      ],
    );
  }
}

class _AppBarTitle extends StatelessWidget {
  const _AppBarTitle();

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Biblia',
      style: TextStyle(
        color: Colors.white,
        fontSize: _BibleScreenState._titleFontSize,
      ),
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

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: _BibleScreenState._searchBarMargin,
      child: TextField(
        controller: _controller,
        onTapOutside: (event) => FocusScope.of(context).unfocus(),
        onChanged: widget.onChanged,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontFamily: 'DM Sans',
        ),
        decoration: InputDecoration(
          hintStyle: const TextStyle(color: Colors.grey),
          hintText: 'Search books...',
          prefixIcon: const Icon(Icons.search),
          suffixIcon: _controller.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear, color: Colors.grey),
                  onPressed: () {
                    _controller.clear();
                    widget.onChanged('');
                  },
                )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
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
            Navigator.push(
              context,
              MaterialPageRoute<VerseSelectScreen>(
                builder: (context) =>
                    VerseSelectScreen(chapterNumber: chapter.number),
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
