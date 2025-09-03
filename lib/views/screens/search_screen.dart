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
      backgroundColor: appColor,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            backgroundColor: appColorDarker,
            expandedHeight: 150,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      appColorDarker,
                      appColorDarker.withOpacity(0.8),
                    ],
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: CustomSearchBar(
                        hintText: 'Buscar versículos...',
                        onChanged: (query) {
                          context.read<SearchVersesBloc>().add(
                                SearchVersesEvent.search(
                                    widget.user.bible, query),
                              );
                        },
                        controller: _searchController,
                        focusNode: _searchFocusNode,
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).padding.top),
                  ],
                ),
              ),
              titlePadding: const EdgeInsets.only(left: 20, bottom: 16),
              title: const Text(
                'Buscar',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          BlocBuilder<SearchVersesBloc, SearchVersesState>(
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () => const SliverFillRemaining(
                  child: Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  ),
                ),
                loaded: (verses) {
                  if (_searchController.text.isEmpty) {
                    return const SliverFillRemaining(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Escribe el parte del versiculo para buscar. \nO Intenta buscando el versiculo asi: "Salmos 23:6"',
                              style: TextStyle(color: Colors.white54),
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  return verses.isEmpty
                      ? const SliverFillRemaining(
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'No se encontraron resultados',
                                  style: TextStyle(color: Colors.white54),
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
