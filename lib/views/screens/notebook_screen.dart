import 'package:bible_app/blocs/blocs.dart';
import 'package:bible_app/data/data.dart';
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
      backgroundColor: appColor,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute<NoteScreen>(
              builder: (_) => NoteScreen(
                isNewNote: true,
                note: NoteModel(
                  id: 0,
                  date: date.format(DateTime.now()),
                  color: Colors.white.value,
                  verses: const [],
                  title: '',
                  content: '',
                ),
                buttonText: 'Add',
                onSaved: (title, content, color) {
                  setState(() {
                    context.read<NotesBloc>().add(
                          NotesEvent.addNote(
                            NoteModel(
                              id: DateTime.now().millisecondsSinceEpoch,
                              title: title,
                              content: content,
                              verses: const [],
                              date: date.format(DateTime.now()),
                              color: color,
                            ),
                          ),
                        );
                  });
                },
              ),
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
                      'No notes yet',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.only(
                      top: 20,
                    ),
                    child: SingleChildScrollView(
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.75,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 20,
                            right: 20,
                          ),
                          child: ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            padding: EdgeInsets.zero,
                            itemCount: notes.length,
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                              height: 10,
                            ),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return NoteCard(
                                note: notes[index],
                                index: index,
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute<NoteScreen>(
                                      builder: (_) => NoteScreen(
                                        isNewNote: false,
                                        note: notes[index],
                                        buttonText: 'Update',
                                        onSaved: (title, content, color) {
                                          setState(() {
                                            context.read<NotesBloc>().add(
                                                  NotesEvent.editNote(
                                                    index,
                                                    NoteModel(
                                                      id: notes[index].id,
                                                      title: title,
                                                      content: content,
                                                      verses:
                                                          notes[index].verses,
                                                      date: date.format(
                                                        DateTime.now(),
                                                      ),
                                                      color: color,
                                                    ),
                                                  ),
                                                );
                                          });
                                        },
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
          );
        },
      ),
    );
  }
}
