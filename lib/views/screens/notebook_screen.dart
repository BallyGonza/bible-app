import 'package:bible_app/blocs/blocs.dart';
import 'package:bible_app/views/views.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NoteBookScreen extends StatefulWidget {
  const NoteBookScreen({super.key});

  @override
  State<NoteBookScreen> createState() => _NoteBookScreenState();
}

class _NoteBookScreenState extends State<NoteBookScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute<NoteScreen>(
              builder: (_) => const NoteScreen.add(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 150,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: false,
              background: Container(
                color: Theme.of(context).colorScheme.primary,
              ),
              titlePadding: const EdgeInsets.only(
                left: 16,
                bottom: 16,
              ),
              title: const Text(
                'Notas',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                ),
              ),
            ),
          ),
          BlocBuilder<NotesBloc, NotesState>(
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () => const SliverFillRemaining(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
                loaded: (notes) {
                  return notes.isEmpty
                      ? const SliverFillRemaining(
                          child: Center(
                            child: Text(
                              'Aún no hay notas',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                        )
                      : SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              final note = notes[index];
                              return NoteCard(
                                index: index,
                                onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute<NoteScreen>(
                                    builder: (_) => NoteScreen(
                                      index: index,
                                      note: notes[index],
                                    ),
                                  ),
                                ),
                                note: note,
                              );
                            },
                            childCount: notes.length,
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
