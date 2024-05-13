import 'package:bible_app/blocs/blocs.dart';
import 'package:bible_app/data/data.dart';
import 'package:bible_app/views/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BibleScreen extends StatefulWidget {
  const BibleScreen({required this.user, super.key});

  final UserModel user;

  @override
  State<BibleScreen> createState() => _BibleScreenState();
}

class _BibleScreenState extends State<BibleScreen> {
  @override
  void initState() {
    context.read<SearchBarBookBloc>().add(
          SearchBarBookEvent.init(widget.user),
        );
    super.initState();
  }

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
              background: Column(
                children: <Widget>[
                  const SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 6, 16, 16),
                    child: SearchBar(
                      hintText: 'Search Bible',
                      onChanged: (value) {
                        context.read<SearchBarBookBloc>().add(
                              SearchBarBookEvent.search(
                                widget.user.bible,
                                value.toLowerCase(),
                              ),
                            );
                      },
                    ),
                  ),
                ],
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
          BlocBuilder<SearchBarBookBloc, SearchBarBookState>(
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () {
                  return const SliverFillRemaining(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                },
                loaded: (books) {
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final book = books[index];
                        return BookCard(
                          book: book,
                        );
                      },
                      childCount: books.length,
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
