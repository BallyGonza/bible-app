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
      backgroundColor: Theme.of(context).colorScheme.surface,
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
            backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
            surfaceTintColor: Theme.of(context).colorScheme.surfaceTint,
            expandedHeight: 150,
            pinned: true,
            elevation: 0,
            shadowColor: Theme.of(context).colorScheme.shadow.withOpacity(0.1),
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: false,
              background: Container(
                color: Theme.of(context).colorScheme.surfaceContainer,
              ),
              titlePadding: const EdgeInsets.only(
                left: 16,
                bottom: 16,
              ),
              title: Text(
                'Notas',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.onSurface,
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
                      ? SliverFillRemaining(
                          child: Center(
                            child: Text(
                              'Aún no hay notas',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurfaceVariant,
                                  ),
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
