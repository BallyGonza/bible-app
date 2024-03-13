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
      appBar: AppBar(
        title: const Text(
          'Notebook',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
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
      body: BlocBuilder<NotesBloc, NotesState>(
        builder: (context, state) {
          return state.maybeWhen(
            orElse: () => const CircularProgressIndicator(),
            loaded: (notes) => notes.isEmpty
                ? const Center(
                    child: Text(
                      'No notes yet...',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                : ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: notes.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return NoteCard(
                        note: notes[index],
                        index: index,
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute<NoteScreen>(
                              builder: (_) => NoteScreen(
                                index: index,
                                note: notes[index],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
          );
        },
      ),
    );
  }
}
