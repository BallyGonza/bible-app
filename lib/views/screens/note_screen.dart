// ignore_for_file: lines_longer_than_80_chars

import 'package:auto_size_text_field/auto_size_text_field.dart';
import 'package:bible_app/blocs/blocs.dart';
import 'package:bible_app/core/core.dart';
import 'package:bible_app/data/data.dart';
import 'package:bible_app/views/views.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
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

class NotePageState extends State<NoteScreen> {
  final _pageController = PageController();
  final _titleController = TextEditingController();
  final _authorController = TextEditingController();
  final _contentController = TextEditingController();
  int _currentIndex = 0;
  late Color _currentColor;
  late Color _iconColor;
  late bool _isEditing;
  late Color _fontColor;

  @override
  void initState() {
    super.initState();
    _isEditing = widget.isNewNote;
    _titleController.text = widget.note?.title ?? '';
    _authorController.text = widget.note?.author ?? '';
    _contentController.text = widget.note?.content ?? '';
    // Use safe defaults - will be updated in didChangeDependencies
    _currentColor = Color(widget.note?.color ?? Colors.white.value);
    _iconColor = Colors.black;
    _fontColor = Colors.black;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Initialize theme-dependent colors here where context is available
    if (widget.note?.color == null) {
      _currentColor = Theme.of(context).colorScheme.surfaceContainer;
    }
    // Calculate appropriate text and icon colors based on current background color
    final luminance = _currentColor.computeLuminance();
    _iconColor = luminance > 0.5 ? Colors.black87 : Colors.white;
    _fontColor = luminance > 0.5 ? Colors.black87 : Colors.white;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _authorController.dispose();
    _contentController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void _onColorChanged(Color color) {
    setState(() {
      _currentColor = color;
      // Calculate appropriate text and icon colors based on background luminance
      final luminance = _currentColor.computeLuminance();
      _iconColor = luminance > 0.5 ? Colors.black87 : Colors.white;
      _fontColor = luminance > 0.5 ? Colors.black87 : Colors.white;
    });
  }

  void _saveNewNote(BuildContext context) {
    context.read<NotesBloc>().add(
          NotesEvent.addNote(
            NoteModel(
              id: DateTime.now().millisecondsSinceEpoch,
              title: _titleController.text,
              author: _authorController.text,
              content: _contentController.text,
              verses: const [],
              date: date.format(DateTime.now()),
              color: _currentColor.value ==
                      Theme.of(context).colorScheme.surface.value
                  ? Theme.of(context).colorScheme.surfaceContainer.value
                  : _currentColor.value,
            ),
          ),
        );
    CustomSnackBar.showSuccess(context, text: 'Nota guardada');
  }

  void _updateNote(BuildContext context) {
    context.read<NotesBloc>().add(
          NotesEvent.editNote(
            widget.index,
            NoteModel(
              id: widget.note!.id,
              title: _titleController.text,
              author: _authorController.text,
              content: _contentController.text,
              verses: widget.note!.verses,
              date: date.format(
                DateTime.now(),
              ),
              color: _currentColor.value,
            ),
          ),
        );
    CustomSnackBar.showSuccess(context, text: 'Nota actualizada');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _currentColor,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarIconBrightness:
              Theme.of(context).brightness == Brightness.light
                  ? Brightness.dark
                  : Brightness.light,
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: FaIcon(FontAwesomeIcons.arrowLeft, color: _iconColor),
        ),
        actions: [
          IconButton(
            icon: FaIcon(FontAwesomeIcons.pencil, color: _iconColor),
            onPressed: () {
              setState(() {
                _isEditing = !_isEditing;
              });
            },
          ),
          IconButton(
            onPressed: () {
              setState(() {
                widget.isNewNote ? _saveNewNote(context) : _updateNote(context);
              });
              Navigator.of(context).pop();
            },
            icon: FaIcon(FontAwesomeIcons.check, color: _iconColor),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 16,
        ),
        child: Column(
          children: [
            AutoSizeTextField(
              enabled: _isEditing,
              controller: _titleController,
              decoration: InputDecoration(
                hintText: 'Titulo...',
                hintStyle: TextStyle(color: _fontColor.withOpacity(0.6)),
                filled: false,
                border: InputBorder.none,
              ),
              style: TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.bold,
                color: _fontColor,
                height: 1.2,
              ),
              maxLines: 1,
              textAlign: TextAlign.left,
              cursorColor: _fontColor,
              textInputAction: TextInputAction.done,
              minFontSize: 18,
              stepGranularity: 2,
              fullwidth: true,
            ),
            Row(
              children: [
                if (_authorController.text.isNotEmpty)
                  Text(
                    "Autor:",
                    style: TextStyle(
                      color: _fontColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      height: 1.4,
                    ),
                  ),
                const SizedBox(width: 8),
                Expanded(
                  child: AutoSizeTextField(
                    enabled: _isEditing,
                    controller: _authorController,
                    decoration: InputDecoration(
                      filled: false,
                      hintText: 'Autor (Opcional)',
                      hintStyle: TextStyle(color: _fontColor.withOpacity(0.6)),
                      border: InputBorder.none,
                    ),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.italic,
                      color: _fontColor,
                      height: 1.4,
                    ),
                    textAlign: TextAlign.left,
                    cursorColor: _fontColor,
                    textCapitalization: TextCapitalization.sentences,
                    maxLines: 1,
                    stepGranularity: 2,
                    fullwidth: true,
                  ),
                ),
              ],
            ),
            Divider(color: _fontColor.withOpacity(0.5)),
            Expanded(
              child: PageView(
                controller: _pageController,
                children: [
                  SingleChildScrollView(
                    child: TextField(
                      enabled: _isEditing,
                      controller: _contentController,
                      decoration: InputDecoration(
                        hintText: 'Descripción...',
                        filled: false,
                        hintStyle: TextStyle(
                          color: _fontColor.withOpacity(0.6),
                          fontStyle: FontStyle.italic,
                        ),
                        border: InputBorder.none,
                      ),
                      style: TextStyle(
                        fontSize: 18,
                        color: _fontColor,
                        fontWeight: FontWeight.normal,
                        height: 1.5,
                      ),
                      keyboardType: TextInputType.multiline,
                      textAlign: TextAlign.left,
                      cursorColor: _fontColor,
                      textCapitalization: TextCapitalization.sentences,
                      maxLines: null,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.70,
                    child: widget.note?.verses.isEmpty ?? true
                        ? Center(
                            child: Text(
                              'No se han seleccionado versículos.',
                              style:
                                  TextStyle(color: _fontColor.withOpacity(0.6)),
                            ),
                          )
                        : BlocBuilder<NotesBloc, NotesState>(
                            builder: (context, state) {
                              return ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                itemCount: widget.note?.verses.length ?? 0,
                                itemBuilder: (context, index) {
                                  final verse = widget.note!.verses[index];
                                  return Slidable(
                                    key: ValueKey(index),
                                    endActionPane: ActionPane(
                                      extentRatio: 0.25,
                                      dragDismissible: false,
                                      motion: const ScrollMotion(),
                                      children: [
                                        SlidableAction(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          onPressed: (_) {
                                            showDialog<AlertDialog>(
                                              context: context,
                                              builder: (context) {
                                                return CustomAlertDialog(
                                                  title: 'Eliminar versículo',
                                                  content: Text(
                                                    '¿Estás seguro de que quieres eliminar este versículo?',
                                                  ),
                                                  primaryActionTitle:
                                                      'Eliminar',
                                                  onPrimaryPressed: (_) {
                                                    context
                                                        .read<NotesBloc>()
                                                        .add(
                                                          NotesEvent
                                                              .removeVerse(
                                                            widget.index,
                                                            index,
                                                          ),
                                                        );
                                                  },
                                                );
                                              },
                                            );
                                          },
                                          icon: Icons.delete,
                                          foregroundColor: Theme.of(context)
                                              .colorScheme
                                              .onError,
                                          backgroundColor: Theme.of(context)
                                              .colorScheme
                                              .error,
                                        ),
                                      ],
                                    ),
                                    child: ListTile(
                                      title: Text(
                                        verse.text,
                                        style: TextStyle(
                                          color: _fontColor,
                                          fontSize: 16,
                                          height: 1.4,
                                        ),
                                      ),
                                      subtitle: Text(
                                        '${verse.book} ${verse.chapter}:${verse.number}',
                                        style: TextStyle(
                                          color: _fontColor.withOpacity(0.6),
                                          fontSize: 14,
                                          height: 1.4,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: _currentColor,
        child: Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            bottom: MediaQuery.of(context).viewInsets.bottom + 5.0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Editado: ${widget.note?.date ?? date.format(DateTime.now())}',
                style: TextStyle(
                  color: _fontColor.withOpacity(0.6),
                  fontSize: 14,
                  height: 1.4,
                ),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _currentIndex == 0
                            ? _pageController.animateToPage(
                                1,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              )
                            : _pageController.animateToPage(
                                0,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                        _currentIndex == 0
                            ? _currentIndex = 1
                            : _currentIndex = 0;
                      });
                    },
                    icon: FaIcon(FontAwesomeIcons.book, color: _iconColor),
                  ),
                  IconButton(
                    onPressed: () => CustomModalBottomSheet.colorPicker(
                      context,
                      _onColorChanged,
                    ),
                    icon: FaIcon(FontAwesomeIcons.palette, color: _iconColor),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
