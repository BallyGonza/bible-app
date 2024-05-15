import 'package:bible_app/blocs/blocs.dart';
import 'package:bible_app/data/data.dart';
import 'package:bible_app/views/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
              background: Container(
                padding: const EdgeInsets.only(top: 60, left: 16),
                color: appColor,
                child: const Text(
                  'Bible',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                  ),
                ),
              ),
              titlePadding: const EdgeInsets.only(
                left: 16,
                bottom: 16,
              ),
              title: Container(
                padding: const EdgeInsets.only(right: 16),
                height: 30,
                width: double.infinity,
                child: SearchBar(
                  elevation: MaterialStateProperty.all(0),
                  textCapitalization: TextCapitalization.words,
                  textStyle: MaterialStateProperty.all(
                    const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                  backgroundColor: MaterialStateProperty.all(appColorDarker),
                  leading: FaIcon(
                    size: 9,
                    FontAwesomeIcons.magnifyingGlass,
                    color: Colors.grey[600],
                  ),
                  hintText: 'Search...',
                  hintStyle: MaterialStateProperty.all(
                    TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                    ),
                  ),
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
