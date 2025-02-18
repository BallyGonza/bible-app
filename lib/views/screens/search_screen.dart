import 'package:bible_app/blocs/blocs.dart';
import 'package:bible_app/data/data.dart';
import 'package:bible_app/views/views.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({required this.bible, super.key});

  final BibleModel bible;

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _searchController = TextEditingController();

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
            expandedHeight: 180,
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
                  children: [
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: SearchBar(
                        onTapOutside: (_) {
                          FocusScope.of(context).unfocus();
                        },
                        padding: const MaterialStatePropertyAll(
                          EdgeInsets.symmetric(horizontal: 16),
                        ),
                        controller: _searchController,
                        hintText: 'Buscar versiculos...',
                        hintStyle: MaterialStateProperty.all(
                          TextStyle(color: Colors.grey[600]),
                        ),
                        leading: FaIcon(
                          FontAwesomeIcons.magnifyingGlass,
                          size: 20,
                          color: Colors.grey[600],
                        ),
                        onChanged: (query) {
                          context.read<SearchVersesBloc>().add(
                                SearchVersesEvent.search(widget.bible, query),
                              );
                        },
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
                              'Escribe parte del versiculo para buscar',
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
                                // return Padding(
                                //   padding: const EdgeInsets.only(bottom: 8),
                                //   child: Card(
                                //     color: Colors.white.withOpacity(0.05),
                                //     child: ListTile(
                                //       title: Text(
                                //         verse.text,
                                //         style: const TextStyle(
                                //           color: Colors.white,
                                //           fontSize: 16,
                                //         ),
                                //       ),
                                //       subtitle: Text(
                                //         '${verse.book} ${verse.chapter}:${verse.number}',
                                //         style: TextStyle(
                                //           color: Colors.grey[400],
                                //           fontSize: 14,
                                //         ),
                                //       ),
                                //     ),
                                //   ),
                                // );
                                return VerseCard.onSearch(verse: verse);
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
