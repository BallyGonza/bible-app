import 'package:bible_app/blocs/blocs.dart';
import 'package:bible_app/core/core.dart';
import 'package:bible_app/data/data.dart';
import 'package:bible_app/views/views.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NoteVerseScreen extends StatefulWidget {
  const NoteVerseScreen({
    required this.verse,
    required this.onClose,
    super.key,
  });
  final VerseModel verse;
  final StringCallback onClose;

  @override
  State<NoteVerseScreen> createState() => _NoteVerseScreenState();
}

typedef StringCallback = void Function(String);

class _NoteVerseScreenState extends State<NoteVerseScreen> {
  final _contentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _contentController.text = widget.verse.note?.content ?? '';
  }

  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }

  void _saveNote() {
    Navigator.of(context).pop();
    widget.onClose(_contentController.text);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Nota guardada.'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _deleteNote() {
    widget.verse.note = null;
    context.read<UserBloc>().add(UserEvent.saveVerse(verse: widget.verse));

    Navigator.of(context).pop();
    widget.onClose('');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Nota eliminada.'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: _saveNote,
          backgroundColor: accentColor,
          child: const FaIcon(FontAwesomeIcons.floppyDisk, color: Colors.black),
        ),
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 150,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: false,
                titlePadding: const EdgeInsets.only(
                  left: 50,
                  bottom: 13,
                ),
                background: Container(
                  color: Theme.of(context).colorScheme.primary,
                ),
                title: Text(
                  '${widget.verse.book} ${widget.verse.chapter}:${widget.verse.number}',
                  style: const TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                  ),
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () => showDialog<void>(
                    context: context,
                    builder: (context) => CustomAlertDialog(
                      title: 'Eliminar Nota',
                      content: Text(
                        '¿Estás seguro de que quieres eliminar esta nota?',
                      ),
                      primaryActionTitle: 'Eliminar',
                      onPrimaryPressed: (_) => _deleteNote(),
                    ),
                  ),
                  icon: const FaIcon(
                    FontAwesomeIcons.trashCan,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
              ],
            ),
            SliverFillRemaining(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * (1 / 20),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Card(
                        color: Colors.black.withOpacity(0.1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: SizedBox(
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.verse.text[0].toUpperCase() +
                                      widget.verse.text.substring(1),
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: SingleChildScrollView(
                        child: TextField(
                          controller: _contentController,
                          decoration: const InputDecoration(
                            hintText: 'Agrega una nota...',
                            filled: false,
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontStyle: FontStyle.italic,
                            ),
                            border: InputBorder.none,
                          ),
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                          ),
                          keyboardType: TextInputType.multiline,
                          textAlign: TextAlign.left,
                          cursorColor: Colors.white,
                          textCapitalization: TextCapitalization.sentences,
                          maxLines: null,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
