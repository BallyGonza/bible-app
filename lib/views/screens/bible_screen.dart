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
    super.initState();
    context.read<SearchBarBookBloc>().add(SearchBarBookEvent.init(widget.user));
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
              background: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 10),
                  _buildSearchBar(),
                  SizedBox(height: MediaQuery.of(context).padding.top),
                ],
              ),
              titlePadding: EdgeInsets.only(left: 16, bottom: 16),
              title: Text(
                'Biblia',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                ),
              ),
            ),
          ),
          _buildBookList(),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      child: SearchBar(
        padding: WidgetStateProperty.all(
          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        textCapitalization: TextCapitalization.words,
        leading: FaIcon(
          size: 20,
          FontAwesomeIcons.magnifyingGlass,
          color: Colors.grey[600],
        ),
        hintText: 'Buscar libro...',
        onTapOutside: (event) => FocusScope.of(context).unfocus(),
        onChanged: (value) {
          context.read<SearchBarBookBloc>().add(
                SearchBarBookEvent.search(
                  widget.user.bible,
                  value.toLowerCase(),
                ),
              );
        },
      ),
    );
  }

  Widget _buildBookList() {
    return BlocBuilder<SearchBarBookBloc, SearchBarBookState>(
      builder: (context, state) {
        return state.maybeWhen(
          orElse: () => const SliverFillRemaining(
            child: Center(child: CircularProgressIndicator()),
          ),
          loaded: (books) => SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final book = books[index];
                return BookCard(book: book);
              },
              childCount: books.length,
            ),
          ),
        );
      },
    );
  }
}
