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
  late VerseModel _currentVerse;

  @override
  void initState() {
    super.initState();
    _currentVerse = widget.verse;
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
  void didUpdateWidget(VerseCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.verse != oldWidget.verse) {
      setState(() {
        _currentVerse = widget.verse;
        _hasNote = widget.verse.note != null;
      });
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    _isFocused = false;
    super.dispose();
  }

  void _onColorChanged(Color color) {
    // Create a new verse with the updated color
    final updatedVerse = _currentVerse.copyWith(color: color.value);

    // Update the local state
    setState(() {
      _currentVerse = updatedVerse;
    });

    // Save the change to the BLoC
    context.read<UserBloc>().add(
          UserEvent.saveVerse(verse: updatedVerse),
        );
  }

  void _onNoteAdded(String note) {
    final updatedVerse =
        _currentVerse.copyWith(note: VerseNoteModel(content: note));

    setState(() {
      _currentVerse = updatedVerse;
      _hasNote = true;
    });

    context.read<UserBloc>().add(
          UserEvent.saveVerse(verse: updatedVerse),
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
                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                foregroundColor:
                    Theme.of(context).colorScheme.onPrimaryContainer,
                borderRadius:
                    const BorderRadius.horizontal(left: Radius.circular(12)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FaIcon(FontAwesomeIcons.bookmark,
                        size: 20,
                        color:
                            Theme.of(context).colorScheme.onPrimaryContainer),
                    const SizedBox(height: 4),
                    Text(
                      'Agregar a',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onPrimaryContainer,
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
                    context,
                    _onColorChanged,
                    _currentVerse.color != null
                        ? Color(_currentVerse.color!)
                        : Colors.white),
                backgroundColor:
                    Theme.of(context).colorScheme.secondaryContainer,
                foregroundColor:
                    Theme.of(context).colorScheme.onSecondaryContainer,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FaIcon(FontAwesomeIcons.palette,
                        size: 20,
                        color:
                            Theme.of(context).colorScheme.onSecondaryContainer),
                    const SizedBox(height: 4),
                    Text(
                      'Resaltar',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onSecondaryContainer,
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
                        verse: _currentVerse, onClose: _onNoteAdded),
                  ),
                ),
                backgroundColor:
                    Theme.of(context).colorScheme.tertiaryContainer,
                foregroundColor:
                    Theme.of(context).colorScheme.onTertiaryContainer,
                borderRadius:
                    const BorderRadius.horizontal(right: Radius.circular(12)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FaIcon(FontAwesomeIcons.noteSticky,
                        size: 20,
                        color:
                            Theme.of(context).colorScheme.onTertiaryContainer),
                    const SizedBox(height: 4),
                    Text(
                      'Nota',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onTertiaryContainer,
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
                  ? Theme.of(context).colorScheme.surfaceContainerHighest
                  : Colors.transparent,
              child: GestureDetector(
                onLongPress: () {
                  Clipboard.setData(
                    ClipboardData(
                        text:
                            '"${_currentVerse.text}"\n${_currentVerse.book} ${_currentVerse.chapter}:${_currentVerse.number} RVR1960'),
                  );
                  // Show snackbar
                  CustomSnackBar.showSuccess(context,
                      text: 'Versiculo copiado');
                },
                onTap: () {
                  if (widget.onSelect != null) {
                    widget.onSelect!(_currentVerse);
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
                                color: Color(_currentVerse.color ??
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
    return RichText(
      text: TextSpan(
        children: [
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: VerseNumber(
              number: _currentVerse.number,
              style: _numberStyle(),
              visible: widget.type == VerseCardType.bible,
            ),
          ),
          TextSpan(
            text: widget.type == VerseCardType.bible
                ? _currentVerse.text
                : '${_currentVerse.text[0].toUpperCase()}${_currentVerse.text.substring(1)}',
            style: _textStyle(),
          ),
        ],
      ),
    );
  }

  Widget _buildChapterAndNumber() {
    final textTheme = Theme.of(context).textTheme;

    return Text(
      '${_currentVerse.book} ${_currentVerse.chapter}:${_currentVerse.number}',
      style: textTheme.bodySmall?.copyWith(
        color: _getColor(),
        fontStyle: _isFocused ? FontStyle.italic : FontStyle.normal,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  TextStyle _numberStyle() {
    final textTheme = Theme.of(context).textTheme;

    return textTheme.bodyLarge?.copyWith(
          color: _getColor(),
          fontStyle: _isFocused ? FontStyle.italic : FontStyle.normal,
          fontWeight: FontWeight.w800,
        ) ??
        const TextStyle();
  }

  TextStyle _textStyle() {
    final textTheme = Theme.of(context).textTheme;

    return textTheme.bodyLarge?.copyWith(
          color: _getColor(),
          fontStyle: _isFocused ? FontStyle.italic : FontStyle.normal,
          height: 1.4,
        ) ??
        const TextStyle();
  }

  Color _getColor() {
    final colorScheme = Theme.of(context).colorScheme;

    if (_currentVerse.color != null) {
      return Color(_currentVerse.color!);
    }

    // Use Material 3 surface color for better contrast
    return _isFocused ? colorScheme.primary : colorScheme.onSurface;
  }

  void _showAddToNoteModal(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true, // Material 3 bottom sheet handle
      backgroundColor: colorScheme.surfaceContainerLow,
      builder: (context) => Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.8,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: 24, vertical: 16), // Material 3 spacing
          child: BlocBuilder<NotesBloc, NotesState>(
            builder: (context, state) {
              if (state is NotesLoading) {
                return SizedBox(
                  height: 200,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: colorScheme.primary,
                    ),
                  ),
                );
              } else if (state is NotesLoaded) {
                final notes = state.notes;
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Header with Material 3 styling
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Agregar a nota',
                          style: textTheme.headlineSmall?.copyWith(
                            color: colorScheme.onSurface,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        IconButton(
                          onPressed: () => Navigator.of(context).pop(),
                          icon: Icon(
                            Icons.close,
                            color: colorScheme.onSurfaceVariant,
                          ),
                          style: IconButton.styleFrom(
                            backgroundColor:
                                colorScheme.surfaceContainerHighest,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16), // Material 3 spacing
                    if (notes.isEmpty)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 32),
                        child: Column(
                          children: [
                            Icon(
                              Icons.note_alt_outlined,
                              size: 48,
                              color: colorScheme.onSurfaceVariant,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'No tienes notas guardadas',
                              textAlign: TextAlign.center,
                              style: textTheme.bodyLarge?.copyWith(
                                color: colorScheme.onSurface,
                              ),
                            ),
                          ],
                        ),
                      )
                    else
                      Flexible(
                        child: ListView.separated(
                          shrinkWrap: true,
                          physics: const ClampingScrollPhysics(),
                          itemCount: notes.length,
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 4), // Material 3 spacing
                          itemBuilder: (context, index) {
                            final note = notes[index];
                            final isSelected =
                                note.verses.contains(widget.verse);

                            return Card(
                              elevation: 0,
                              color: Color(note.color),
                              margin: EdgeInsets.zero,
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).pop();

                                  if (!isSelected) {
                                    context.read<NotesBloc>().add(
                                          NotesEvent.addVerse(
                                            index,
                                            widget.verse,
                                          ),
                                        );
                                    CustomSnackBar.showSuccess(
                                      context,
                                      text: 'Versículo agregado a la nota',
                                    );
                                  } else {
                                    CustomSnackBar.showError(
                                      context,
                                      text: 'El versículo ya está en la nota',
                                    );
                                  }
                                },
                                borderRadius: BorderRadius.circular(12),
                                child: Padding(
                                  padding: const EdgeInsets.all(
                                      16), // Material 3 spacing
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              note.title,
                                              style: textTheme.titleMedium
                                                  ?.copyWith(
                                                color: _calculateNoteTextColor(
                                                    Color(note.color)),
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            if (note.author != null &&
                                                note.author!.isNotEmpty) ...[
                                              const SizedBox(height: 4),
                                              Text(
                                                'Por ${note.author}',
                                                style: textTheme.bodySmall
                                                    ?.copyWith(
                                                  color:
                                                      _calculateNoteTextColor(
                                                              Color(note.color))
                                                          .withOpacity(0.7),
                                                ),
                                              ),
                                            ],
                                          ],
                                        ),
                                      ),
                                      if (isSelected) ...[
                                        const SizedBox(width: 12),
                                        Icon(
                                          Icons.check_circle_rounded,
                                          color: colorScheme.primary,
                                          size: 24,
                                        ),
                                      ],
                                    ],
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
                return SizedBox(
                  height: 200,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.error_outline,
                          color: colorScheme.error,
                          size: 48,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Error al cargar notas',
                          style: textTheme.bodyLarge?.copyWith(
                            color: colorScheme.error,
                          ),
                        ),
                      ],
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
