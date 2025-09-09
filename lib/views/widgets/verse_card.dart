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
    // No need to set local state anymore - colors are calculated on build
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
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

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
                backgroundColor: colorScheme.primaryContainer,
                foregroundColor: colorScheme.onPrimaryContainer,
                borderRadius:
                    const BorderRadius.horizontal(left: Radius.circular(12)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FaIcon(FontAwesomeIcons.bookmark,
                        size: 20, color: colorScheme.onPrimaryContainer),
                    const SizedBox(height: 4),
                    Text(
                      'Agregar a',
                      style: textTheme.labelSmall?.copyWith(
                        color: colorScheme.onPrimaryContainer,
                        fontWeight: FontWeight.w500,
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
                backgroundColor: colorScheme.secondaryContainer,
                foregroundColor: colorScheme.onSecondaryContainer,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FaIcon(FontAwesomeIcons.palette,
                        size: 20, color: _getColor()),
                    const SizedBox(height: 4),
                    Text(
                      'Resaltar',
                      style: textTheme.labelSmall?.copyWith(
                        color: colorScheme.onSecondaryContainer,
                        fontWeight: FontWeight.w500,
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
                backgroundColor: colorScheme.tertiaryContainer,
                foregroundColor: colorScheme.onTertiaryContainer,
                borderRadius:
                    const BorderRadius.horizontal(right: Radius.circular(12)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FaIcon(FontAwesomeIcons.noteSticky,
                        size: 20, color: colorScheme.onTertiaryContainer),
                    const SizedBox(height: 4),
                    Text(
                      'Nota',
                      style: textTheme.labelSmall?.copyWith(
                        color: colorScheme.onTertiaryContainer,
                        fontWeight: FontWeight.w500,
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
                  ? colorScheme.surfaceContainerHighest
                  : widget.type == VerseCardType.bible
                      ? Colors.transparent
                      : colorScheme.primary,
              child: GestureDetector(
                onLongPress: () {
                  Clipboard.setData(
                    ClipboardData(
                        text:
                            '"${widget.verse.text}"\n${widget.verse.book} ${widget.verse.chapter}:${widget.verse.number} RVR1960'),
                  );
                  // Show snackbar
                  CustomSnackBar.showSuccess(context,
                      text: 'Versiculo copiado');
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
    final textTheme = Theme.of(context).textTheme;

    return Text(
      '${widget.verse.book} ${widget.verse.chapter}:${widget.verse.number}',
      style: textTheme.bodySmall?.copyWith(
        color: _getColor(),
        fontStyle: _isFocused ? FontStyle.italic : FontStyle.normal,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  TextStyle _numberStyle() {
    final textTheme = Theme.of(context).textTheme;

    return textTheme.bodySmall?.copyWith(
          color: _getColor(),
          fontStyle: _isFocused ? FontStyle.italic : FontStyle.normal,
          fontWeight: FontWeight.w600,
        ) ??
        const TextStyle();
  }

  TextStyle _textStyle() {
    final textTheme = Theme.of(context).textTheme;

    return textTheme.bodyLarge?.copyWith(
          color: _getColor(),
          fontStyle: _isFocused ? FontStyle.italic : FontStyle.normal,
          fontWeight: FontWeight.w400,
          height: 1.4,
        ) ??
        const TextStyle();
  }

  Color _getColor() {
    final colorScheme = Theme.of(context).colorScheme;

    if (widget.verse.color != null) {
      return Color(widget.verse.color!);
    }

    // Use Material 3 surface color for better contrast
    return _isFocused ? colorScheme.primary : colorScheme.onSurface;
  }

  void _showAddToNoteModal(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      context: context,
      builder: (context) => DraggableScrollableSheet(
        expand: false,
        builder: (context, scrollController) => Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainerLow,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                color: colorScheme.shadow.withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: BlocBuilder<NotesBloc, NotesState>(
            builder: (context, state) {
              if (state is NotesLoading) {
                return Center(
                  child: CircularProgressIndicator(
                    color: colorScheme.primary,
                  ),
                );
              } else if (state is NotesLoaded) {
                final notes = state.notes;
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Agregar a:',
                          style: textTheme.titleLarge?.copyWith(
                            color: colorScheme.onSurface,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: FaIcon(
                            FontAwesomeIcons.xmark,
                            color: colorScheme.onSurfaceVariant,
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
                                color: colorScheme.onSurfaceVariant,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'No tienes predicas / notas guardadas',
                                textAlign: TextAlign.center,
                                style: textTheme.titleMedium?.copyWith(
                                  color: colorScheme.onSurface,
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
                                    SnackBar(
                                      content: Text(
                                        'Versiculo agregado a la nota',
                                        style: textTheme.bodyMedium?.copyWith(
                                          color: colorScheme.onInverseSurface,
                                        ),
                                      ),
                                      backgroundColor:
                                          colorScheme.inverseSurface,
                                    ),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'El versiculo ya se encuentra en la nota',
                                        style: textTheme.bodyMedium?.copyWith(
                                          color: colorScheme.onInverseSurface,
                                        ),
                                      ),
                                      backgroundColor:
                                          colorScheme.inverseSurface,
                                    ),
                                  );
                                }
                              },
                              child: Card(
                                color: Color(notes[index].color),
                                margin: const EdgeInsets.symmetric(vertical: 4),
                                child: ListTile(
                                  title: Text(
                                    notes[index].title,
                                    style: textTheme.titleMedium?.copyWith(
                                      color: _calculateNoteTextColor(
                                          Color(notes[index].color)),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  trailing: Icon(
                                    notes[index].verses.contains(widget.verse)
                                        ? Icons.check_circle
                                        : null,
                                    color: colorScheme.primary,
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
                return Center(
                  child: Text(
                    'Error loading notes',
                    style: textTheme.bodyLarge?.copyWith(
                      color: colorScheme.error,
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  /// Calculate appropriate text color based on note card background color
  Color _calculateNoteTextColor(Color backgroundColor) {
    final luminance = backgroundColor.computeLuminance();
    return luminance > 0.5 ? Colors.black87 : Colors.white;
  }
}
