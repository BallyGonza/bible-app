import 'package:bible_app/blocs/blocs.dart';
import 'package:bible_app/data/data.dart';
import 'package:bible_app/views/views.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ReadingVerseCard extends StatefulWidget {
  const ReadingVerseCard({
    required this.verse,
    this.onSelect,
    super.key,
  });

  final VerseModel verse;
  final Function(VerseModel)? onSelect;

  @override
  State<ReadingVerseCard> createState() => _ReadingVerseCardState();
}

class _ReadingVerseCardState extends State<ReadingVerseCard>
    with SingleTickerProviderStateMixin {
  bool _isFocused = false;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.02).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onColorChanged(Color color) {
    context.read<UserBloc>().add(
          UserEvent.saveVerse(verse: widget.verse.copyWith(color: color.value)),
        );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) => Transform.scale(
        scale: _scaleAnimation.value,
        child: Slidable(
          closeOnScroll: true,
          startActionPane: ActionPane(
            extentRatio: 0.25,
            motion: const ScrollMotion(),
            children: [
              CustomSlidableAction(
                onPressed: (_) => _showAddToNoteModal(context),
                backgroundColor: Colors.blue.shade200,
                foregroundColor: Colors.white,
                borderRadius:
                    const BorderRadius.horizontal(left: Radius.circular(12)),
                child: FaIcon(FontAwesomeIcons.floppyDisk, size: 20),
              ),
            ],
          ),
          endActionPane: ActionPane(
            extentRatio: 0.5,
            motion: const ScrollMotion(),
            children: [
              CustomSlidableAction(
                onPressed: (_) => CustomModalBottomSheet.colorPicker(
                    context, _onColorChanged),
                backgroundColor: Colors.green.shade200,
                foregroundColor: Colors.white,
                child: FaIcon(FontAwesomeIcons.palette, size: 20),
              ),
              CustomSlidableAction(
                onPressed: (_) => Navigator.push(
                  context,
                  MaterialPageRoute<NoteVerseScreen>(
                    builder: (context) => NoteVerseScreen(verse: widget.verse),
                  ),
                ),
                backgroundColor: Colors.deepPurple.shade200,
                foregroundColor: Colors.white,
                borderRadius:
                    const BorderRadius.horizontal(right: Radius.circular(12)),
                child: FaIcon(FontAwesomeIcons.noteSticky, size: 20),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                return Card(
                  elevation: _isFocused ? 4 : 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  color: _isFocused ? Colors.grey[900] : Colors.transparent,
                  child: GestureDetector(
                    onLongPress: () {
                      Clipboard.setData(
                        ClipboardData(
                            text:
                                "\"${widget.verse.text}\"\n${widget.verse.book} ${widget.verse.chapter}:${widget.verse.number} RVR1960"),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Versiculo copiado',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      );
                    },
                    onTap: () {
                      if (widget.onSelect != null) {
                        widget.onSelect!(widget.verse);
                      }
                      setState(() => _isFocused = !_isFocused);
                      if (_isFocused) {
                        _animationController.forward();
                      } else {
                        _animationController.reverse();
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: SizedBox(
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildVerseText(),
                            if (widget.verse.note != null) ...[
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  FaIcon(
                                    FontAwesomeIcons.noteSticky,
                                    size: 14,
                                    color: Color(widget.verse.color ??
                                            Colors.white.value)
                                        .withOpacity(0.6),
                                  ),
                                ],
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
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
      isScrollControlled: true,
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: appColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        height: MediaQuery.of(context).size.height * 0.6,
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
                          'Agregar a:',
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
                    if (notes.isEmpty)
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'No tienes notas',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                  color: Colors.white,
                                ),
                          ),
                        ],
                      )
                    else
                      Expanded(
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: notes.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.pop(context);

                                if (!notes[index]
                                    .verses
                                    .contains(widget.verse)) {
                                  context.read<NotesBloc>().add(
                                        NotesEvent.addVerse(
                                          index,
                                          widget.verse,
                                        ),
                                      );
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'Versiculo agregado a la nota',
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
                                        'El versiculo ya se encuentra en la nota',
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
