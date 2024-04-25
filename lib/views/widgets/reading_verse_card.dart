import 'package:bible_app/blocs/blocs.dart';
import 'package:bible_app/data/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
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
  late Color _currentColor;
  bool _isFocused = false;

  @override
  void initState() {
    _currentColor = Color(widget.verse.color ?? Colors.transparent.value);
    super.initState();
  }

  void _onColorChanged(Color color) {
    setState(() {
      _currentColor = color;
      widget.verse.color = color.value;
      context.read<UserBloc>().add(UserEvent.saveVerse(verse: widget.verse));
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isFocused = !_isFocused;
        });
      },
      child: Slidable(
        startActionPane: ActionPane(
          extentRatio: 0.20,
          dragDismissible: false,
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              borderRadius: BorderRadius.circular(5),
              onPressed: (_) {
                showModalBottomSheet<Container>(
                  backgroundColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(11),
                  ),
                  context: context,
                  builder: (context) => Container(
                    padding: const EdgeInsets.all(8),
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
                            return ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              itemCount: notes.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                    context.read<NotesBloc>().add(
                                          NotesEvent.addVerse(
                                            index,
                                            widget.verse,
                                          ),
                                        );
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
                                      subtitle: notes[index].author != null
                                          ? Text(
                                              notes[index].author!,
                                              style: const TextStyle(
                                                color: Colors.grey,
                                                fontStyle: FontStyle.italic,
                                              ),
                                            )
                                          : null,
                                      trailing: Icon(
                                        notes[index]
                                                .verses
                                                .contains(widget.verse)
                                            ? Icons.check
                                            : null,
                                        color: Colors.green,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        );
                      },
                    ),
                  ),
                );
              },
              icon: FontAwesomeIcons.floppyDisk,
              foregroundColor: Colors.white,
              backgroundColor: Colors.blue,
            ),
          ],
        ),
        endActionPane: ActionPane(
          extentRatio: 0.20,
          dragDismissible: false,
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              borderRadius: BorderRadius.circular(5),
              onPressed: (_) {
                showModalBottomSheet<Container>(
                  backgroundColor: Colors.transparent,
                  context: context,
                  builder: (context) {
                    return Container(
                      color: appColor,
                      height: MediaQuery.of(context).size.height * 0.5,
                      child: BlockPicker(
                        availableColors: [
                          Colors.white,
                          Colors.red[300]!,
                          Colors.red[200]!,
                          Colors.purple[300]!,
                          Colors.purple[200]!,
                          Colors.purple[100]!,
                          Colors.deepPurple[300]!,
                          Colors.deepPurple[200]!,
                          Colors.deepPurple[100]!,
                          Colors.indigo[200]!,
                          Colors.blue,
                          Colors.blue[200]!,
                          Colors.blue[300]!,
                          Colors.cyan,
                          Colors.cyan[200]!,
                          Colors.cyan[300]!,
                          Colors.teal,
                          Colors.teal[200]!,
                          Colors.green[200]!,
                          Colors.green[300]!,
                          Colors.orange[300]!,
                          Colors.deepOrange,
                          Colors.brown[200]!,
                          Colors.grey,
                          Colors.blueGrey,
                          Colors.yellow[200]!,
                          Colors.amber[200]!,
                          Colors.amber[300]!,
                          Colors.lime[200]!,
                          Colors.lime[300]!,
                          Colors.lightGreen[200]!,
                          Colors.lightGreen[300]!,
                          Colors.lightBlue[200]!,
                          Colors.lightBlue[300]!,
                          Colors.pink[200]!,
                          Colors.pink[300]!,
                        ],
                        layoutBuilder: (context, colors, child) {
                          return GridView.count(
                            physics: const BouncingScrollPhysics(),
                            crossAxisCount: 6,
                            children: [
                              ...colors.map(
                                (color) => GestureDetector(
                                  onTap: () {
                                    if (color == Colors.white) {
                                      setState(() {
                                        widget.verse.color = null;
                                      });
                                    } else {
                                      _onColorChanged(color);
                                    }
                                    Navigator.pop(context);
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
                    );
                  },
                );
              },
              icon: FontAwesomeIcons.palette,
              foregroundColor: Colors.white,
              backgroundColor: accentColor,
            ),
          ],
        ),
        child: ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          tileColor: _isFocused ? Colors.grey[900] : Colors.transparent,
          leading: Text(
            '${widget.verse.number}',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: widget.verse.color != null
                  ? Color(widget.verse.color!)
                  : Colors.white,
            ),
          ),
          title: Stack(
            children: [
              Text(
                widget.verse.text,
                style: TextStyle(
                  fontSize: 20,
                  color: widget.verse.color != null
                      ? Color(widget.verse.color!)
                      : Colors.white,
                  fontStyle: _isFocused ? FontStyle.italic : FontStyle.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
