import 'package:bible_app/blocs/blocs.dart';
import 'package:bible_app/data/data.dart';
import 'package:bible_app/views/views.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({required this.user, super.key});

  final UserModel user;

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _searchController = TextEditingController();
  final _searchFocusNode = FocusNode();
  final bibleRepository = BibleRepository();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
            surfaceTintColor: Theme.of(context).colorScheme.surfaceTint,
            expandedHeight: 150,
            pinned: true,
            elevation: 0,
            shadowColor: Theme.of(context).colorScheme.shadow.withOpacity(0.1),
            flexibleSpace: FlexibleSpaceBar(
              background: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomSearchBar(
                    hintText: 'Buscar versículos...',
                    onChanged: (query) {
                      context.read<SearchVersesBloc>().add(
                            SearchVersesEvent.search(widget.user.bible, query),
                          );
                    },
                    controller: _searchController,
                    focusNode: _searchFocusNode,
                  ),
                ],
              ),
              titlePadding: const EdgeInsets.only(left: 20, bottom: 16),
              centerTitle: false,
              title: Text(
                'Buscar',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
              ),
            ),
          ),
          BlocBuilder<SearchVersesBloc, SearchVersesState>(
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () => const SliverFillRemaining(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
                loaded: (verses) {
                  if (_searchController.text.isEmpty) {
                    return SliverFillRemaining(
                      child: EmptyState(
                        icon: Icons.search,
                        title: 'Buscar versículos',
                        subtitle:
                            'Escribe el parte del versiculo para buscar. \nO Intenta buscando el versiculo asi: "Salmos 23:6"',
                      ),
                    );
                  }

                  return verses.isEmpty
                      ? SliverFillRemaining(
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'No se encontraron resultados',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurfaceVariant,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : SliverPadding(
                          padding: const EdgeInsets.all(16),
                          sliver: SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                final verse = verses[index];
                                final chapter =
                                    bibleRepository.getChapterOfVerse(
                                  bible: widget.user.bible,
                                  verse: verse,
                                );

                                return VerseCard.onSearch(
                                  verse: verse,
                                  onSelect: (verse) async {
                                    _searchFocusNode.unfocus();
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => ReadingScreen(
                                          chapter: chapter,
                                          verse: verse,
                                          book: widget.user.bible.books
                                              .where(
                                                (book) =>
                                                    book.chapters.contains(
                                                  chapter,
                                                ),
                                              )
                                              .first,
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              childCount: verses.length,
                            ),
                          ),
                        );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
