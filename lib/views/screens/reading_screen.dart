// ignore_for_file: lines_longer_than_80_chars

import 'package:bible_app/data/data.dart';
import 'package:bible_app/views/views.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ReadingScreen extends StatefulWidget {
  const ReadingScreen({
    required this.chapter,
    super.key,
  });

  final ChapterModel chapter;

  @override
  State<ReadingScreen> createState() => _ReadingScreenState();
}

class _ReadingScreenState extends State<ReadingScreen> {
  List<VerseModel> _verses = [];
  final _sc = ScrollController();
  void _shareSelectedVerses() {
    if (_verses.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No verses selected'),
        ),
      );
      return;
    }

    final versesText =
        _verses.map((verse) => '[${verse.number}] ${verse.text}').join(' ');
    final formattedText = '''
$versesText
${widget.chapter.verses[0].book} ${widget.chapter.number}:${_verses.first.number}-${_verses.last.number} RVR1960
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
              IconButton(
                onPressed: _verses.isEmpty ? null : _shareSelectedVerses,
                icon: FaIcon(
                  FontAwesomeIcons.share,
                  color: _verses.isEmpty ? Colors.grey : Colors.white,
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
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final verse = widget.chapter.verses[index];
                return ReadingVerseCard(
                  verse: verse,
                  onSelect: (verse) {
                    setState(() {
                      final verseIndex =
                          _verses.indexWhere((v) => v.number == verse.number);
                      if (verseIndex != -1) {
                        _verses.removeAt(verseIndex);
                      } else {
                        _verses.add(verse);
                        _verses.sort((a, b) => a.number.compareTo(b.number));
                      }
                    });
                  },
                );
              },
              childCount: widget.chapter.verses.length,
            ),
          ),
        ],
      ),
    );
  }
}
