import 'package:bible_app/blocs/blocs.dart';
import 'package:bible_app/data/data.dart';
import 'package:bible_app/views/views.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
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
    _currentColor = Color(widget.note?.color ?? Colors.white.value);
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
        child: PageView(
          controller: _pageController,
          children: [
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Wrap(
                children: [
                  SizedBox(
                    height: 45,
                    child: TextField(
                      enabled: _isEditing,
                      controller: _titleController,
                      decoration: InputDecoration(
                        hintText: 'Titulo',
                        hintStyle:
                            TextStyle(color: _fontColor.withOpacity(0.6)),
                        border: InputBorder.none,
                      ),
                      style: TextStyle(
                        fontSize: 24,
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
                    height: 25,
                    child: TextField(
                      enabled: _isEditing,
                      controller: _authorController,
                      decoration: InputDecoration(
                        hintText: 'by Author...',
                        hintStyle:
                            TextStyle(color: _fontColor.withOpacity(0.6)),
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
                  TextField(
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
                ],
              ),
            ),
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.75,
                child: widget.note?.verses.isEmpty ?? true
                    ? Center(
                        child: Text(
                          'No se han seleccionado versículos...',
                          style: TextStyle(color: _fontColor),
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
                                      borderRadius: BorderRadius.circular(8),
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
                                                context.read<NotesBloc>().add(
                                                      NotesEvent.removeVerse(
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
                                      label: 'Delete',
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
                                        color: _fontColor.withOpacity(0.6)),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
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
                    onPressed: () {
                      showModalBottomSheet<SizedBox>(
                        context: context,
                        builder: (context) {
                          return SizedBox(
                            height: MediaQuery.of(context).size.height * 0.55,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: BlockPicker(
                                    availableColors: [
                                      Colors.white,
                                      Colors.red,
                                      Colors.red[300]!,
                                      Colors.purple,
                                      Colors.purple[200]!,
                                      Colors.purple[100]!,
                                      Colors.deepPurple,
                                      Colors.deepPurple[300]!,
                                      Colors.deepPurple[200]!,
                                      Colors.indigo,
                                      Colors.indigo[200]!,
                                      Colors.blue,
                                      Colors.blue[200]!,
                                      Colors.cyan,
                                      Colors.cyan[200]!,
                                      Colors.teal,
                                      Colors.teal[200]!,
                                      Colors.green,
                                      Colors.green[200]!,
                                      Colors.green[300]!,
                                      Colors.orange[300]!,
                                      Colors.deepOrange,
                                      Colors.brown,
                                      Colors.brown[200]!,
                                      Colors.grey,
                                      Colors.blueGrey,
                                      Colors.black,
                                    ],
                                    layoutBuilder: (context, colors, child) {
                                      return GridView.count(
                                        crossAxisCount: 4,
                                        children: [
                                          ...colors.map(
                                            (color) => GestureDetector(
                                              onTap: () {
                                                _onColorChanged(color);
                                              },
                                              child: Container(
                                                color: color,
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                    pickerColor: _currentColor,
                                    onColorChanged: _onColorChanged,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
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
  }
}
