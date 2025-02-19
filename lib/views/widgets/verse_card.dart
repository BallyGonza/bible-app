import 'package:bible_app/blocs/blocs.dart';
import 'package:bible_app/data/data.dart';
import 'package:bible_app/views/views.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum VerseCardType { bible, search }

class VerseCard extends StatefulWidget {
  const VerseCard.onBible({
    required this.verse,
    this.isFocused = false,
    this.onSelect,
    super.key,
  }) : type = VerseCardType.bible;

  const VerseCard.onSearch({
    required this.verse,
    this.onSelect,
    this.isFocused = false,
    super.key,
  }) : type = VerseCardType.search;

  final VerseModel verse;
  final Function(VerseModel)? onSelect;
  final VerseCardType type;
  final bool isFocused;

  @override
  State<VerseCard> createState() => _VerseCardState();
}

class _VerseCardState extends State<VerseCard>
    with SingleTickerProviderStateMixin {
  late bool _isFocused;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  Color _color = Colors.white;
  bool _hasNote = false;

  @override
  void initState() {
    super.initState();
    _isFocused = widget.isFocused;
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.02).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _hasNote = widget.verse.note != null;
  }

  @override
  void dispose() {
    _animationController.dispose();
    _isFocused = false;
    super.dispose();
  }

  void _onColorChanged(Color color) {
    context.read<UserBloc>().add(
          UserEvent.saveVerse(verse: widget.verse.copyWith(color: color.value)),
        );
    setState(() {
      _color = color;
    });
  }

  void _onNoteAdded(String note) {
    context.read<UserBloc>().add(UserEvent.saveVerse(
        verse: widget.verse.copyWith(note: VerseNoteModel(content: note))));
    setState(() {
      _hasNote = true;
    });
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
                backgroundColor: appColor,
                foregroundColor: Colors.white,
                borderRadius:
                    const BorderRadius.horizontal(left: Radius.circular(12)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FaIcon(FontAwesomeIcons.bookmark,
                        size: 20, color: accentColor),
                    const SizedBox(height: 4),
                    Text(
                      'Agregar a',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
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
                backgroundColor: appColor,
                foregroundColor: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FaIcon(FontAwesomeIcons.palette, size: 20, color: _color),
                    const SizedBox(height: 4),
                    Text(
                      'Resaltar',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              CustomSlidableAction(
                onPressed: (_) => Navigator.push(
                  context,
                  MaterialPageRoute<NoteVerseScreen>(
                    builder: (context) => NoteVerseScreen(
                        verse: widget.verse, onClose: _onNoteAdded),
                  ),
                ),
                backgroundColor: appColor,
                foregroundColor: Colors.white,
                borderRadius:
                    const BorderRadius.horizontal(right: Radius.circular(12)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FaIcon(FontAwesomeIcons.noteSticky,
                        size: 20, color: accentColor),
                    const SizedBox(height: 4),
                    Text(
                      'Nota',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Card(
              elevation: _isFocused ? 4 : 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              color: _isFocused
                  ? Colors.grey[900]
                  : widget.type == VerseCardType.bible
                      ? Colors.transparent
                      : appColorDarker,
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
                  if (widget.type == VerseCardType.bible) {
                    setState(() => _isFocused = !_isFocused);
                    if (_isFocused) {
                      _animationController.forward();
                    } else {
                      _animationController.reverse();
                    }
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
                        if (widget.type == VerseCardType.search) ...[
                          _buildChapterAndNumber(),
                        ],
                        if (_hasNote) ...[
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
          TextSpan(
              text: widget.type == VerseCardType.bible
                  ? '${widget.verse.number} '
                  : '',
              style: _numberStyle()),
          TextSpan(
              text: widget.type == VerseCardType.bible
                  ? widget.verse.text
                  : '${widget.verse.text[0].toUpperCase()}${widget.verse.text.substring(1)}',
              style: _textStyle()),
        ],
      ),
    );
  }

  Widget _buildChapterAndNumber() {
    return Text(
      '${widget.verse.book} ${widget.verse.chapter}:${widget.verse.number}',
      style: TextStyle(
        fontSize: 14,
        color: _getColor(),
        fontStyle: _isFocused ? FontStyle.italic : FontStyle.normal,
      ),
    );
  }

  TextStyle _numberStyle() {
    return TextStyle(
      fontSize: 14,
      color: _getColor(),
      fontStyle: _isFocused ? FontStyle.italic : FontStyle.normal,
    );
  }

  TextStyle _textStyle() {
    return TextStyle(
      fontSize: 20,
      color: _getColor(),
      fontStyle: _isFocused ? FontStyle.italic : FontStyle.normal,
    );
  }

  Color _getColor() {
    return widget.verse.color != null ? Color(widget.verse.color!) : _color;
  }

  void _showAddToNoteModal(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      context: context,
      builder: (context) => DraggableScrollableSheet(
        expand: false,
        builder: (context, scrollController) => Container(
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
          child: BlocBuilder<NotesBloc, NotesState>(
            builder: (context, state) {
              if (state is NotesLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is NotesLoaded) {
                final notes = state.notes;
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
                      Expanded(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FaIcon(
                                FontAwesomeIcons.solidStickyNote,
                                size: 40,
                                color: Colors.white.withOpacity(0.7),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'No tienes predicas / notas guardadas',
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(
                                      color: Colors.white,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      )
                    else
                      Expanded(
                        child: ListView.builder(
                          controller: scrollController,
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
              } else {
                return const Center(child: Text('Error loading notes'));
              }
            },
          ),
        ),
      ),
    );
  }
}
