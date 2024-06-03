import 'package:bible_app/blocs/blocs.dart';
import 'package:bible_app/data/data.dart';
import 'package:bible_app/views/views.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NoteVerseScreen extends StatefulWidget {
  const NoteVerseScreen({
    required this.verse,
    super.key,
  });

  final VerseModel verse;

  @override
  State<NoteVerseScreen> createState() => _NoteVerseScreenState();
}

class _NoteVerseScreenState extends State<NoteVerseScreen> {
  final _contentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _contentController.text = widget.verse.note?.content ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              showDialog<void>(
                context: context,
                builder: (context) => CustomAlertDialog.red(
                  title: 'Delete note',
                  description: 'Are you sure you want to delete this note?',
                  rightButtonText: 'Delete',
                  onRightButtonPressed: () {
                    setState(() {
                      widget.verse.note = null;
                      context
                          .read<UserBloc>()
                          .add(UserEvent.saveVerse(verse: widget.verse));
                    });
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Note deleted.'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                ),
              );
            },
            icon: const FaIcon(
              FontAwesomeIcons.trashCan,
              color: Colors.white,
              size: 18,
            ),
          ),
        ],
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const FaIcon(FontAwesomeIcons.arrowLeft, color: Colors.white),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            widget.verse.note =
                VerseNoteModel(content: _contentController.text);
            context
                .read<UserBloc>()
                .add(UserEvent.saveVerse(verse: widget.verse));
          });
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Note saved.'),
              duration: Duration(seconds: 2),
            ),
          );
        },
        backgroundColor: accentColor,
        child: const FaIcon(FontAwesomeIcons.floppyDisk, color: Colors.black),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * (1 / 20),
        ),
        child: Column(
          children: [
            Card(
              color: Colors.black.withOpacity(0.1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${widget.verse.book} ${widget.verse.chapter}:${widget.verse.number}',
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      widget.verse.text,
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
            const SizedBox(height: 10),
            Expanded(
              child: SingleChildScrollView(
                child: TextField(
                  controller: _contentController,
                  decoration: const InputDecoration(
                    hintText: 'Descripción...',
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
    );
  }
}
