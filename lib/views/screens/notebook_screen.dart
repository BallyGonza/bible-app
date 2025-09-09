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
  // Constants for consistent spacing and sizing
  static const double _appBarExpandedHeight = 150.0;
  static const double _gridMainAxisSpacing = 16.0;
  static const double _gridChildAspectRatio = 0.75;
  static const double _emptyStateIconSize = 64.0;
  static const double _appBarTitleLeftPadding = 16.0;
  static const double _appBarTitleBottomPadding = 16.0;

  // Calculate responsive cross axis count based on screen width
  int _calculateCrossAxisCount(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth >= 1200) {
      return 4; // Large tablets/desktops
    } else if (screenWidth >= 800) {
      return 3; // Tablets
    } else if (screenWidth >= 600) {
      return 2; // Large phones/small tablets
    } else {
      return 2; // Small phones
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute<NoteScreen>(
              builder: (_) => const NoteScreen.add(),
            ),
          );
        },
        label: const Text('Nueva nota'),
        icon: const Icon(Icons.add),
        tooltip: 'Crear nueva nota',
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
            surfaceTintColor: Theme.of(context).colorScheme.surfaceTint,
            expandedHeight: _appBarExpandedHeight,
            pinned: true,
            elevation: 0,
            shadowColor: Theme.of(context).colorScheme.shadow.withOpacity(0.1),
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: false,
              background: Container(
                color: Theme.of(context).colorScheme.surfaceContainer,
              ),
              titlePadding: const EdgeInsets.only(
                left: _appBarTitleLeftPadding,
                bottom: _appBarTitleBottomPadding,
              ),
              title: Semantics(
                label: 'Título de la pantalla: Notas',
                child: Text(
                  'Notas',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
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
                          child: EmptyState(
                            icon: Icons.note,
                            title: 'Aún no hay notas',
                            subtitle: 'Presiona el botón + para crear una nota',
                            iconSize: _emptyStateIconSize,
                            titleStyle:
                                Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurfaceVariant,
                                    ),
                          ),
                        )
                      : SliverGrid(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: _calculateCrossAxisCount(context),
                            mainAxisSpacing: _gridMainAxisSpacing,
                            childAspectRatio: _gridChildAspectRatio,
                          ),
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              final note = notes[index];
                              return Semantics(
                                key: ValueKey('note_${notes[index].id}_$index'),
                                label: 'Nota ${index + 1}: ${note.title.isNotEmpty ? note.title : 'Sin título'}',
                                hint: 'Toca para abrir la nota',
                                child: NoteCard(
                                  key: ValueKey('note_card_${notes[index].id}_$index'),
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
                                ),
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
