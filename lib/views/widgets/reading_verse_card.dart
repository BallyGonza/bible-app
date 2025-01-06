import 'package:bible_app/blocs/blocs.dart';
import 'package:bible_app/data/data.dart';
import 'package:bible_app/views/views.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ReadingVerseCard extends StatefulWidget {
  const ReadingVerseCard({
    required this.verse,
    super.key,
  });

  final VerseModel verse;

  @override
  State<ReadingVerseCard> createState() => _ReadingVerseCardState();
}

class _ReadingVerseCardState extends State<ReadingVerseCard> {
  bool _isFocused = false;

  void _onColorChanged(Color color) {
    context.read<UserBloc>().add(
          UserEvent.saveVerse(verse: widget.verse.copyWith(color: color.value)),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Slidable(
      startActionPane: ActionPane(
        extentRatio: 0.20,
        dragDismissible: false,
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            borderRadius: BorderRadius.circular(5),
            onPressed: (_) => _showAddToNoteModal(context),
            icon: FontAwesomeIcons.floppyDisk,
            foregroundColor: Colors.white,
            backgroundColor: Colors.white,
          ),
        ],
      ),
      endActionPane: ActionPane(
        extentRatio: 0.40,
        dragDismissible: false,
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (_) =>
                CustomModalBottomSheet.colorPicker(context, _onColorChanged),
            icon: FontAwesomeIcons.palette,
            foregroundColor: Colors.white,
            backgroundColor: Colors.white,
          ),
          SlidableAction(
            onPressed: (_) => Navigator.push(
              context,
              MaterialPageRoute<NoteVerseScreen>(
                builder: (context) => NoteVerseScreen(verse: widget.verse),
              ),
            ),
            icon: FontAwesomeIcons.noteSticky,
            foregroundColor: Colors.white,
            backgroundColor: Colors.white,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            return ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              onTap: () => setState(() => _isFocused = !_isFocused),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              tileColor: _isFocused ? Colors.grey[900] : Colors.transparent,
              title: _buildVerseText(),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (widget.verse.note != null)
                    const FaIcon(
                      FontAwesomeIcons.noteSticky,
                      size: 15,
                    )
                  else
                    const SizedBox.shrink(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildVerseText() {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(text: '${widget.verse.number} ', style: _numberStyle()),
          TextSpan(text: widget.verse.text, style: _textStyle()),
        ],
      ),
    );
  }

  TextStyle _numberStyle() {
    return TextStyle(
      fontSize: 14,
      color: _color(),
      fontStyle: _isFocused ? FontStyle.italic : FontStyle.normal,
    );
  }

  TextStyle _textStyle() {
    return TextStyle(
      fontSize: 20,
      color: _color(),
      fontStyle: _isFocused ? FontStyle.italic : FontStyle.normal,
    );
  }

  Color _color() {
    return widget.verse.color != null
        ? Color(widget.verse.color!)
        : Colors.white;
  }

  void _showAddToNoteModal(BuildContext context) {
    showModalBottomSheet<Container>(
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(11),
      ),
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: appColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        height: MediaQuery.of(context).size.height * 0.5,
        child: BlocBuilder<NotesBloc, NotesState>(
          builder: (context, state) {
            return state.maybeWhen(
              orElse: () {
                return const CircularProgressIndicator();
              },
              loaded: (notes) {
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Add to Note',
                          style:
                              Theme.of(context).textTheme.titleLarge!.copyWith(
                                    color: Colors.white,
                                  ),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const FaIcon(
                            FontAwesomeIcons.xmark,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: notes.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.pop(context);

                              if (!notes[index].verses.contains(widget.verse)) {
                                context.read<NotesBloc>().add(
                                      NotesEvent.addVerse(
                                        index,
                                        widget.verse,
                                      ),
                                    );
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Verse added to note',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Verse already added to note',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                );
                              }
                            },
                            child: Card(
                              color: Color(notes[index].color),
                              child: ListTile(
                                title: Text(
                                  notes[index].title,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(
                                        color: notes[index].color ==
                                                Colors.white.value
                                            ? Colors.black
                                            : Colors.white,
                                      ),
                                ),
                                trailing: Icon(
                                  notes[index].verses.contains(widget.verse)
                                      ? Icons.check
                                      : null,
                                  color: Colors.green,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
