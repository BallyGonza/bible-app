import 'package:bible_app/blocs/blocs.dart';
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
    CustomSnackBar.showSuccess(context, text: 'Nota guardada');
  }

  void _deleteNote() {
    widget.verse.note = null;
    context.read<UserBloc>().add(UserEvent.saveVerse(verse: widget.verse));

    Navigator.of(context).pop();
    Navigator.of(context).pop();

    widget.onClose('');
    CustomSnackBar.showSuccess(context, text: 'Nota eliminada');
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: _saveNote,
          backgroundColor: colorScheme.secondaryContainer,
          foregroundColor: colorScheme.onPrimaryContainer,
          child: FaIcon(
            FontAwesomeIcons.floppyDisk,
            color: colorScheme.onPrimaryContainer,
          ),
        ),
        body: CustomScrollView(
          slivers: [
            CustomSliverAppBar(
              title:
                  '${widget.verse.book} ${widget.verse.chapter}:${widget.verse.number}',
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
                  icon: FaIcon(FontAwesomeIcons.trashCan),
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
                        color: colorScheme.surfaceContainerHighest,
                        elevation: 2,
                        shadowColor: colorScheme.shadow.withOpacity(0.2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: SizedBox(
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.verse.text[0].toUpperCase() +
                                      widget.verse.text.substring(1),
                                  style: textTheme.bodyLarge?.copyWith(
                                    color: colorScheme.onSurface,
                                    fontStyle: FontStyle.italic,
                                    height: 1.5,
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
                          decoration: InputDecoration(
                            hintText: 'Agrega una nota...',
                            filled: false,
                            hintStyle: textTheme.bodyLarge?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                              fontStyle: FontStyle.italic,
                            ),
                            border: InputBorder.none,
                          ),
                          style: textTheme.bodyLarge?.copyWith(
                            color: colorScheme.onSurface,
                            height: 1.5,
                          ),
                          keyboardType: TextInputType.multiline,
                          textAlign: TextAlign.left,
                          cursorColor: colorScheme.primary,
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
