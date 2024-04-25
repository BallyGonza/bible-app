// ignore_for_file: lines_longer_than_80_chars

import 'package:bible_app/blocs/blocs.dart';
import 'package:bible_app/data/data.dart';
import 'package:bible_app/views/views.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  final _sc = ScrollController();
  final _expansionTileController = ExpansionTileController();
  bool isExpanded = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColor,
      appBar: AppBar(
        title: Text(
          '${widget.chapter.verses[0].book} ${widget.chapter.number}',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              return ExpansionTile(
                backgroundColor: appColor,
                collapsedBackgroundColor: appColor,
                controller: _expansionTileController,
                onExpansionChanged: (value) {
                  setState(() {
                    isExpanded = value;
                  });
                },
                title: Text(
                  'Select Verse',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: Colors.white,
                      ),
                ),
                trailing: Icon(
                  isExpanded == true
                      ? FontAwesomeIcons.chevronUp
                      : FontAwesomeIcons.chevronDown,
                  size: 15,
                  color: Colors.white,
                ),
                children: [
                  Wrap(
                    children: [
                      for (final verse in widget.chapter.verses)
                        GestureDetector(
                          onTap: () {
                            isExpanded
                                ? _expansionTileController.collapse()
                                : _expansionTileController.expand();
                            isExpanded = !isExpanded;

                            _sc.animateTo(
                              verse.number * 100,
                              duration: const Duration(seconds: 1),
                              curve: Curves.fastOutSlowIn,
                            );
                          },
                          child: VerseCard(
                            isSelected: false,
                            verse: verse,
                          ),
                        ),
                    ],
                  ),
                ],
              );
            },
          ),
          Expanded(
            child: ListView.separated(
              controller: _sc,
              physics: const BouncingScrollPhysics(),
              itemCount: widget.chapter.verses.length,
              separatorBuilder: (context, index) => const Divider(
                height: 3,
              ),
              itemBuilder: (context, index) {
                final verse = widget.chapter.verses[index];
                return ReadingVerseCard(verse: verse);
              },
            ),
          ),
        ],
      ),
    );
  }
}
