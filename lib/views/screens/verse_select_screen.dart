// ignore_for_file: lines_longer_than_80_chars

import 'package:bible_app/blocs/blocs.dart';
import 'package:bible_app/data/data.dart';
import 'package:bible_app/views/views.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VerseSelectScreen extends StatefulWidget {
  const VerseSelectScreen({
    required this.chapter,
    super.key,
  });

  final ChapterModel chapter;

  @override
  State<VerseSelectScreen> createState() => _VerseSelectScreenState();
}

class _VerseSelectScreenState extends State<VerseSelectScreen> {
  bool isSelected = false;
  VerseModel? selectedVerse;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColor,
      appBar: AppBar(
        title:
            Text('${widget.chapter.verses[0].book} ${widget.chapter.number}'),
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            return state.maybeWhen(
              loaded: (user) {
                return Wrap(
                  children: [
                    for (final verse in widget.chapter.verses)
                      InkWell(
                        onTap: () {
                          setState(() {
                            selectedVerse == verse
                                ? selectedVerse = null
                                : selectedVerse = verse;
                          });
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
                              height: verse.text.length > 100 ? 205 : 155,
                              child: ListTile(
                                subtitle: Text(
                                  '${verse.book} ${widget.chapter.number}:${verse.number}',
                                  textAlign: TextAlign.right,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                        color: Colors.white,
                                      ),
                                ),
                                title: Text(
                                  verse.text,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(
                                        color: Colors.white,
                                      ),
                                ),
                              ),
                            ),
                          );
                        },
                        onLongPress: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute<ReadingScreen>(
                              builder: (context) => ReadingScreen(
                                chapter: widget.chapter,
                                verse: verse,
                              ),
                            ),
                          );
                          setState(() {
                            selectedVerse = null;
                          });
                        },
                        child: VerseCard(
                          isSelected: selectedVerse == verse,
                          verse: verse,
                        ),
                      ),
                  ],
                );
              },
              orElse: () => const Center(
                child: CircularProgressIndicator(),
              ),
            );
          },
        ),
      ),
    );
  }
}
