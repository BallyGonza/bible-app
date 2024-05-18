// ignore_for_file: lines_longer_than_80_chars

import 'package:bible_app/blocs/blocs.dart';
import 'package:bible_app/data/data.dart';
import 'package:bible_app/views/views.dart';
import 'package:flutter/material.dart';
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
  late Color _fontColor;
  late bool _isEditing;

  @override
  void initState() {
    super.initState();
    _isEditing = widget.isNewNote;
    _titleController.text = widget.note?.title ?? '';
    _authorController.text = widget.note?.author ?? '';
    _contentController.text = widget.note?.content ?? '';
    _currentColor = Color(widget.note?.color ?? appColor.value);
    _iconColor = _currentColor != Colors.white ? Colors.white : Colors.black;
    _fontColor = _currentColor != Colors.white ? Colors.white : Colors.black;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _authorController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void _onColorChanged(Color color) {
    setState(() {
      _currentColor = color;
      _iconColor = _currentColor != Colors.white ? Colors.white : Colors.black;
      _fontColor = _currentColor != Colors.white ? Colors.white : Colors.black;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _currentColor,
      appBar: AppBar(
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
              // habilitar edicion
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
          horizontal: MediaQuery.of(context).size.width * (1 / 20),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 80,
              child: TextField(
                enabled: _isEditing,
                controller: _titleController,
                decoration: InputDecoration(
                  hintText: 'Titulo',
                  hintStyle: TextStyle(color: _fontColor.withOpacity(0.6)),
                  border: InputBorder.none,
                ),
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                  color: _fontColor,
                ),
                textAlign: TextAlign.left,
                cursorColor: _fontColor,
                textCapitalization: TextCapitalization.words,
                textInputAction: TextInputAction.done,
              ),
            ),
            SizedBox(
              height: 20,
              child: TextField(
                enabled: _isEditing,
                controller: _authorController,
                decoration: InputDecoration(
                  hintText: 'by Author...',
                  hintStyle: TextStyle(color: _fontColor.withOpacity(0.6)),
                  border: InputBorder.none,
                ),
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.italic,
                  color: _fontColor,
                ),
                textAlign: TextAlign.left,
                cursorColor: _fontColor,
                textCapitalization: TextCapitalization.sentences,
              ),
            ),
            const SizedBox(height: 10),
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
                                                return CustomAlertDialog.red(
                                                  title: 'Delete Verse',
                                                  description:
                                                      'Are you sure you want to delete this verse?',
                                                  rightButtonText: 'Delete',
                                                  onRightButtonPressed: () {
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
                                          foregroundColor: Colors.white,
                                          backgroundColor: Colors.red,
                                        ),
                                      ],
                                    ),
                                    child: ListTile(
                                      title: Text(
                                        verse.text,
                                        style: TextStyle(color: _fontColor),
                                      ),
                                      subtitle: Text(
                                        '${verse.book} ${verse.chapter}:${verse.number}',
                                        style: TextStyle(
                                          color: _fontColor.withOpacity(0.6),
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
                'Edited: ${widget.note?.date ?? date.format(DateTime.now())}',
                style: TextStyle(color: _fontColor.withOpacity(0.6)),
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
              color: _currentColor.value,
            ),
          ),
        );
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Note created',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
    );
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
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Note updated',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
