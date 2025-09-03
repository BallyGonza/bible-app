import 'package:bible_app/data/data.dart';
import 'package:bible_app/views/views.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ReadingScreen extends StatefulWidget {
  const ReadingScreen({
    required this.chapter,
    this.verse,
    super.key,
  });

  final ChapterModel chapter;
  final VerseModel? verse;

  @override
  State<ReadingScreen> createState() => _ReadingScreenState();
}

class _ReadingScreenState extends State<ReadingScreen> {
  // Constants
  static const double _appBarExpandedHeight = 150.0;
  static const EdgeInsets _titlePadding = EdgeInsets.only(left: 50, bottom: 13);
  static const double _titleFontSize = 24.0;
  static const double _estimatedVerseHeight = 120.0;
  static const Duration _scrollAnimationDuration = Duration(milliseconds: 500);
  static const int _maxScrollRetries = 2;

  // State
  final List<VerseModel> _selectedVerses = [];
  late final List<GlobalKey> _verseKeys;
  late final ScrollController _scrollController;
  late final _VerseSelectionManager _selectionManager;
  late final _ScrollManager _scrollManager;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();
    _verseKeys = List.generate(
      widget.chapter.verses.length,
      (index) => GlobalKey(),
    );

    _selectionManager = _VerseSelectionManager(
      onSelectionChanged: (verses) {
        setState(() {
          _selectedVerses.clear();
          _selectedVerses.addAll(verses);
        });
      },
    );

    _scrollManager = _ScrollManager(
      scrollController: _scrollController,
      verseKeys: _verseKeys,
    );

    if (widget.verse != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollManager.scrollToVerse(widget.verse!, widget.chapter.verses);
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _selectionManager.dispose();
    super.dispose();
  }

  void _handleVerseSelection(VerseModel verse) {
    _selectionManager.toggleVerse(verse);
  }

  void _handleShare() {
    _VerseShareService.shareVerses(
      _selectedVerses,
      widget.chapter,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          _ReadingAppBar(
            chapter: widget.chapter,
            hasSelectedVerses: _selectedVerses.isNotEmpty,
            onShare: _handleShare,
            expandedHeight: _appBarExpandedHeight,
            titlePadding: _titlePadding,
            titleFontSize: _titleFontSize,
          ),
          _VersesList(
            chapter: widget.chapter,
            verseKeys: _verseKeys,
            onVerseSelect: _handleVerseSelection,
          ),
        ],
      ),
    );
  }
}

/// Manages verse selection state and logic
class _VerseSelectionManager {
  _VerseSelectionManager({required this.onSelectionChanged});

  final void Function(List<VerseModel>) onSelectionChanged;
  final List<VerseModel> _selectedVerses = [];

  List<VerseModel> get selectedVerses => List.unmodifiable(_selectedVerses);

  void toggleVerse(VerseModel verse) {
    if (_selectedVerses.contains(verse)) {
      _selectedVerses.remove(verse);
    } else {
      _selectedVerses.add(verse);
      _selectedVerses.sort((a, b) => a.number.compareTo(b.number));
    }
    onSelectionChanged(_selectedVerses);
  }

  void dispose() {
    _selectedVerses.clear();
  }
}

/// Manages scroll behavior and verse navigation
class _ScrollManager {
  _ScrollManager({
    required this.scrollController,
    required this.verseKeys,
  });

  final ScrollController scrollController;
  final List<GlobalKey> verseKeys;

  void scrollToVerse(VerseModel verse, List<VerseModel> verses,
      [int retry = 0]) {
    if (retry > _ReadingScreenState._maxScrollRetries) return;

    final verseIndex = verses.indexWhere((v) => v.number == verse.number);
    if (verseIndex == -1) return;

    final context = verseKeys[verseIndex].currentContext;

    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: _ReadingScreenState._scrollAnimationDuration,
        curve: Curves.easeInOut,
        alignment: 0.5,
      );
    } else {
      // Jump to estimated position to force widget creation
      final estimatedOffset =
          verseIndex * _ReadingScreenState._estimatedVerseHeight;
      scrollController.jumpTo(
        estimatedOffset.clamp(0.0, scrollController.position.maxScrollExtent),
      );

      // Retry after layout update
      WidgetsBinding.instance.addPostFrameCallback((_) {
        scrollToVerse(verse, verses, retry + 1);
      });
    }
  }
}

/// Service for sharing verses
class _VerseShareService {
  static void shareVerses(List<VerseModel> verses, ChapterModel chapter) {
    if (verses.isEmpty) return;

    final versesText =
        verses.map((verse) => '[${verse.number}] ${verse.text}').join(' ');

    final reference = verses.length == 1
        ? '${chapter.verses.first.book} ${chapter.number}:${verses.first.number}'
        : '${chapter.verses.first.book} ${chapter.number}:${verses.first.number}-${verses.last.number}';

    final formattedText = '$versesText\n$reference RVR1960';

    Clipboard.setData(ClipboardData(text: formattedText));
  }
}

/// App bar for reading screen
class _ReadingAppBar extends StatelessWidget {
  const _ReadingAppBar({
    required this.chapter,
    required this.hasSelectedVerses,
    required this.onShare,
    required this.expandedHeight,
    required this.titlePadding,
    required this.titleFontSize,
  });

  final ChapterModel chapter;
  final bool hasSelectedVerses;
  final VoidCallback onShare;
  final double expandedHeight;
  final EdgeInsets titlePadding;
  final double titleFontSize;

  String get _chapterTitle {
    if (chapter.verses.isEmpty) return 'Chapter ${chapter.number}';
    return '${chapter.verses.first.book} ${chapter.number}';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SliverAppBar(
      backgroundColor: theme.appBarTheme.backgroundColor,
      expandedHeight: expandedHeight,
      pinned: true,
      actions: [
        if (hasSelectedVerses)
          IconButton(
            onPressed: onShare,
            icon: const Icon(Icons.share),
            tooltip: 'Share selected verses',
          ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          color: theme.scaffoldBackgroundColor,
        ),
        titlePadding: titlePadding,
        title: Text(
          _chapterTitle,
          style: theme.appBarTheme.titleTextStyle?.copyWith(
            fontSize: titleFontSize,
          ),
        ),
      ),
    );
  }
}

/// List of verses widget
class _VersesList extends StatelessWidget {
  const _VersesList({
    required this.chapter,
    required this.verseKeys,
    required this.onVerseSelect,
  });

  final ChapterModel chapter;
  final List<GlobalKey> verseKeys;
  final void Function(VerseModel) onVerseSelect;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return SliverPadding(
      padding: EdgeInsets.only(bottom: mediaQuery.padding.bottom),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final verse = chapter.verses[index];

            return VerseCard.onBible(
              key: verseKeys[index],
              verse: verse,
              onSelect: onVerseSelect,
            );
          },
          childCount: chapter.verses.length,
        ),
      ),
    );
  }
}
