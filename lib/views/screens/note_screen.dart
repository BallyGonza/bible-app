// ignore_for_file: lines_longer_than_80_chars

import 'package:auto_size_text_field/auto_size_text_field.dart';
import 'package:bible_app/blocs/blocs.dart';
import 'package:bible_app/core/core.dart';
import 'package:bible_app/data/data.dart';
import 'package:bible_app/views/views.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NoteScreen extends StatefulWidget {
  const NoteScreen({
    required this.index,
    required this.note,
    super.key,
  }) : isNewNote = false;

  const NoteScreen.add({
    this.note,
    super.key,
  })  : isNewNote = true,
        index = -1;

  final int index;
  final NoteModel? note;
  final bool isNewNote;

  @override
  NotePageState createState() => NotePageState();
}

class NotePageState extends State<NoteScreen> with TickerProviderStateMixin {
  final _titleController = TextEditingController();
  final _authorController = TextEditingController();
  final _contentController = TextEditingController();
  late Color _currentColor;
  late Color _iconColor;
  late Color _textColor;
  late bool _isEditing;
  late SystemUiOverlayStyle _systemOverlayStyle;
  late AnimationController _fabAnimationController;
  late Animation<double> _fabScaleAnimation;

  @override
  void initState() {
    super.initState();
    _isEditing = widget.isNewNote;
    _titleController.text = widget.note?.title ?? '';
    _authorController.text = widget.note?.author ?? '';
    _contentController.text = widget.note?.content ?? '';

    // Initialize with a safe default - will be updated in didChangeDependencies
    _currentColor = widget.note?.color != null
        ? Color(widget.note!.color)
        : Colors.white; // Temporary default

    _fabAnimationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _fabScaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.1,
    ).animate(CurvedAnimation(
      parent: _fabAnimationController,
      curve: Curves.easeInOut,
    ));

    _updateColors();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Initialize theme-dependent colors here where context is available
    if (widget.note?.color == null && mounted) {
      setState(() {
        _currentColor = Theme.of(context).colorScheme.surface;
        _updateColors();
      });
    } else if (widget.note?.color != null && mounted) {
      // Update colors if we have a note color
      _updateColors();
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _authorController.dispose();
    _contentController.dispose();
    _fabAnimationController.dispose();
    super.dispose();
  }

  void _updateColors() {
    final luminance = _currentColor.computeLuminance();
    _iconColor = luminance > 0.5 ? Colors.black87 : Colors.white;
    _textColor = luminance > 0.5 ? Colors.black87 : Colors.white;
    _systemOverlayStyle = luminance > 0.5
        ? SystemUiOverlayStyle.dark
        : SystemUiOverlayStyle.light;
  }

  void _onColorChanged(Color color) {
    context.read<NotesBloc>().add(
          NotesEvent.editNote(
            widget.index,
            widget.note!.copyWith(color: color.value),
          ),
        );
    setState(() {
      _currentColor = color;
      _updateColors();
    });
  }

  void _deleteNote() {
    if (widget.isNewNote) {
      // If it's a new note, just go back
      Navigator.of(context).pop();
      return;
    }

    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return CustomAlertDialog(
          title: 'Eliminar nota',
          content: const Text(
            '¿Estás seguro de que quieres eliminar esta nota? Esta acción no se puede deshacer.',
          ),
          onPrimaryPressed: (_) {
            context.read<NotesBloc>().add(
                  NotesEvent.deleteNote(widget.index),
                );
            CustomSnackBar.showSuccess(
              context,
              text: 'Nota eliminada',
            );
            // Close dialog and go back
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          },
          primaryActionTitle: 'Eliminar',
        );
      },
    );
  }

  void _saveNote() {
    final note = NoteModel(
      id: widget.isNewNote
          ? DateTime.now().millisecondsSinceEpoch
          : widget.note!.id,
      title: _titleController.text,
      author: _authorController.text,
      content: _contentController.text,
      verses: widget.note?.verses ?? const [],
      date: date.format(DateTime.now()),
      color: _currentColor.value,
    );

    if (widget.isNewNote) {
      context.read<NotesBloc>().add(NotesEvent.addNote(note));
      CustomSnackBar.showSuccess(context, text: 'Nota guardada');
    } else {
      context.read<NotesBloc>().add(NotesEvent.editNote(widget.index, note));
      CustomSnackBar.showSuccess(context, text: 'Nota actualizada');
    }

    Navigator.of(context).pop();
  }

  void _showColorPicker() {
    CustomModalBottomSheet.colorPicker(context, _onColorChanged, _currentColor);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _currentColor,
      appBar: AppBar(
        systemOverlayStyle: _systemOverlayStyle,
        elevation: 0,
        backgroundColor: _currentColor,
        surfaceTintColor: Theme.of(context).colorScheme.surfaceTint,
        shadowColor: Theme.of(context).colorScheme.shadow,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: FaIcon(FontAwesomeIcons.arrowLeft, color: _iconColor),
          style: IconButton.styleFrom(
            foregroundColor: _iconColor,
            backgroundColor: Colors.transparent,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                _isEditing = !_isEditing;
              });
            },
            icon: FaIcon(
              _isEditing ? FontAwesomeIcons.eye : FontAwesomeIcons.pencil,
              color: _iconColor,
            ),
            style: IconButton.styleFrom(
              foregroundColor: _iconColor,
              backgroundColor: Colors.transparent,
            ),
          ),
          PopupMenuButton<String>(
            onSelected: (String value) {
              switch (value) {
                case 'color':
                  _showColorPicker();
                  break;
                case 'delete':
                  _deleteNote();
                  break;
              }
            },
            itemBuilder: (BuildContext context) => [
              PopupMenuItem<String>(
                value: 'color',
                child: Row(
                  children: [
                    Icon(
                      Icons.palette,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(width: 12.0),
                    Text(
                      'Cambiar color',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
              PopupMenuItem<String>(
                value: 'delete',
                child: Row(
                  children: [
                    Icon(
                      Icons.delete,
                      color: Theme.of(context).colorScheme.error,
                    ),
                    const SizedBox(width: 12.0),
                    Text(
                      'Eliminar nota',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Theme.of(context).colorScheme.error,
                          ),
                    ),
                  ],
                ),
              ),
            ],
            icon: FaIcon(
              FontAwesomeIcons.ellipsisVertical,
              color: _iconColor,
            ),
            style: IconButton.styleFrom(
              foregroundColor: _iconColor,
              backgroundColor: Colors.transparent,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title Section
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      enabled: _isEditing,
                      controller: _authorController,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(
                          color: _textColor.withOpacity(0.6),
                        ),
                        label: const Text('Autor (Opcional)'),
                        filled: true,
                        fillColor: _currentColor.withOpacity(0.8),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.zero,
                        isDense: true,
                      ),
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: _textColor,
                            fontStyle: FontStyle.italic,
                          ),
                      maxLines: 1,
                      textAlign: TextAlign.left,
                      cursorColor: _textColor,
                      textInputAction: TextInputAction.next,
                      textCapitalization: TextCapitalization.words,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: AutoSizeTextField(
                        enabled: _isEditing,
                        controller: _titleController,
                        decoration: InputDecoration(
                          hintText: 'Titulo ',
                          hintStyle: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(
                                color: _textColor.withOpacity(0.6),
                                fontWeight: FontWeight.w400,
                              ),
                          filled: true,
                          fillColor: _currentColor.withOpacity(0.8),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.zero,
                          isDense: true,
                        ),
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(
                              color: _textColor,
                              fontWeight: FontWeight.w600,
                            ),
                        textAlign: TextAlign.left,
                        cursorColor: _textColor,
                        textInputAction: TextInputAction.next,
                      ),
                    ),
                  ],
                ),

                // Content Section
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      enabled: _isEditing,
                      controller: _contentController,
                      decoration: InputDecoration(
                        hintText: 'Nota',
                        hintStyle:
                            Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  color: _textColor.withOpacity(0.6),
                                ),
                        filled: true,
                        fillColor: _currentColor.withOpacity(0.8),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.zero,
                        isDense: true,
                      ),
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: _textColor,
                            height: 1.6,
                          ),
                      keyboardType: TextInputType.multiline,
                      textAlign: TextAlign.left,
                      cursorColor: _textColor,
                      textCapitalization: TextCapitalization.sentences,
                      maxLines: null,
                      minLines: 8,
                    ),
                  ],
                ),
                const SizedBox(height: 24.0),

                // Verses Section
                if (widget.note?.verses.isNotEmpty ?? false) ...[
                  Text(
                    'Versículos',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  const SizedBox(height: 12.0),
                  Card(
                    elevation: 1.0,
                    shadowColor:
                        Theme.of(context).colorScheme.shadow.withOpacity(0.05),
                    surfaceTintColor: Theme.of(context).colorScheme.surfaceTint,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: widget.note!.verses.map((verse) {
                          return Container(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .outline
                                      .withOpacity(0.1),
                                  width: 1.0,
                                ),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${verse.book} ${verse.chapter}:${verse.number}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium
                                      ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                                const SizedBox(height: 4.0),
                                Text(
                                  verse.text,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                        color: _textColor,
                                        height: 1.4,
                                      ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],

                const SizedBox(height: 100.0), // Space for FAB
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: _isEditing
          ? ScaleTransition(
              scale: _fabScaleAnimation,
              child: FloatingActionButton.extended(
                onPressed: _saveNote,
                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                foregroundColor:
                    Theme.of(context).colorScheme.onPrimaryContainer,
                elevation: 6.0,
                icon: const Icon(Icons.save),
                label: Text(widget.isNewNote ? 'Guardar' : 'Actualizar'),
              ),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        decoration: BoxDecoration(
          color: _currentColor,
          border: Border(
            top: BorderSide(
              color: Theme.of(context).colorScheme.outline.withOpacity(0.1),
              width: 1.0,
            ),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Última modificación: ${date.format(DateTime.now())}',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: _textColor),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
