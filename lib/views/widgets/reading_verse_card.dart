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
        endActionPane: ActionPane(
          extentRatio: 0.25,
          dragDismissible: false,
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              borderRadius: BorderRadius.circular(8),
              onPressed: (_) {
                showModalBottomSheet<SizedBox>(
                  context: context,
                  builder: (context) {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height * 0.15,
                      child: Expanded(
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
                      ),
                    );
                  },
                );
              },
              icon: FontAwesomeIcons.palette,
              foregroundColor: Colors.white,
              backgroundColor: Colors.blue,
            ),
          ],
        ),
        child: ListTile(
          leading: Text(
            '${widget.verse.number}',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: _isFocused
                  ? Colors.white
                  : widget.verse.color != null
                      ? Colors.white
                      : const Color.fromARGB(255, 80, 80, 80),
            ),
          ),
          title: Stack(
            children: [
              BlocBuilder<UserBloc, UserState>(
                builder: (context, state) {
                  return Text(
                    widget.verse.text,
                    style: TextStyle(
                      fontSize: 20,
                      color: _isFocused
                          ? Colors.white
                          : widget.verse.color != null
                              ? Colors.white
                              : const Color.fromARGB(255, 80, 80, 80),
                      fontStyle:
                          _isFocused ? FontStyle.italic : FontStyle.normal,
                      backgroundColor:
                          Color(widget.verse.color ?? Colors.transparent.value),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
