// ignore_for_file: lines_longer_than_80_chars

import 'package:bible_app/data/data.dart';
import 'package:bible_app/views/views.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
  List<VerseModel> _versesToCopy = [];
  late final List<GlobalKey> _verseKeys;
  final ScrollController _sc = ScrollController();

  @override
  void initState() {
    super.initState();

    _verseKeys = List.generate(
      widget.chapter.verses.length,
      (index) => GlobalKey(),
    );

    WidgetsBinding.instance
        .addPostFrameCallback((_) => _scrollToInitialVerse());
  }

  void _scrollToInitialVerse([int retry = 0]) {
    if (widget.verse == null || retry > 2) return;

    final verseIndex = widget.chapter.verses
        .indexWhere((v) => v.number == widget.verse!.number);

    if (verseIndex == -1) return;

    final context = _verseKeys[verseIndex].currentContext;

    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
        alignment: 0.5,
      );
    } else {
      // Jump to estimated position to force widget creation
      final estimatedOffset = verseIndex * 120.0;
      _sc.jumpTo(estimatedOffset.clamp(0.0, _sc.position.maxScrollExtent));

      // Retry after layout update
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollToInitialVerse(retry + 1);
      });
    }
  }

  void _shareSelectedVerses() {
    final versesText = _versesToCopy
        .map((verse) => '[${verse.number}] ${verse.text}')
        .join(' ');
    final formattedText = '''
$versesText
${widget.chapter.verses[0].book} ${widget.chapter.number}:${_versesToCopy.first.number}-${_versesToCopy.last.number} RVR1960
''';

    Clipboard.setData(ClipboardData(text: formattedText)).then((_) {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColor,
      body: CustomScrollView(
        controller: _sc,
        slivers: [
          SliverAppBar(
            backgroundColor: appColorDarker,
            expandedHeight: 150,
            pinned: true,
            actions: [
              _versesToCopy.isEmpty
                  ? const SizedBox.shrink()
                  : IconButton(
                      onPressed: _shareSelectedVerses,
                      icon: FaIcon(
                        FontAwesomeIcons.share,
                        color:
                            _versesToCopy.isEmpty ? Colors.grey : Colors.white,
                        size: 20,
                      ),
                    ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                color: appColor,
              ),
              titlePadding: const EdgeInsets.only(
                left: 50,
                bottom: 13,
              ),
              title: Text(
                '${widget.chapter.verses[0].book} ${widget.chapter.number}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.only(bottom: 24.0),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final verse = widget.chapter.verses[index];

                  return VerseCard.onBible(
                    key: _verseKeys[index],
                    verse: verse,
                    onSelect: (verse) {
                      setState(() {
                        if (_versesToCopy.contains(verse)) {
                          _versesToCopy.remove(verse);
                        } else {
                          _versesToCopy.add(verse);
                          _versesToCopy
                              .sort((a, b) => a.number.compareTo(b.number));
                        }
                      });
                    },
                  );
                },
                childCount: widget.chapter.verses.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
