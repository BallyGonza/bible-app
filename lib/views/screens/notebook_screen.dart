import 'package:bible_app/blocs/blocs.dart';
import 'package:bible_app/views/views.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class NoteBookScreen extends StatefulWidget {
  const NoteBookScreen({super.key});

  @override
  State<NoteBookScreen> createState() => _NoteBookScreenState();
}

class _NoteBookScreenState extends State<NoteBookScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: BlocBuilder<NotesBloc, NotesState>(
        builder: (context, state) {
          return state.maybeWhen(
            orElse: () => const CircularProgressIndicator(),
            loaded: (notes) => notes.isEmpty
                ? const Center(
                    child: Text('No notes yet'),
                  )
                : SizedBox(
                    height: MediaQuery.of(context).size.height * 0.75,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 20,
                        right: 20,
                      ),
                      child: ListView.separated(
                        padding: EdgeInsets.zero,
                        itemCount: notes.length,
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 10,
                        ),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Slidable(
                            key: ValueKey(notes[index]),
                            endActionPane: ActionPane(
                              extentRatio: 0.25,
                              dragDismissible: false,
                              motion: const ScrollMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: (_) {
                                    context
                                        .read<NotesBloc>()
                                        .add(NotesEvent.delete(index));
                                  },
                                  icon: Icons.delete,
                                  label: 'Delete',
                                ),
                              ],
                            ),
                            child: NoteCard(
                              note: notes[index],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
          );
        },
      ),
    );
  }
}
