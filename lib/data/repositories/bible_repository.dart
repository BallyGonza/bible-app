import 'package:bible_app/data/data.dart';

class BibleRepository {
  BibleRepository();

  ChapterModel getChapterOfVerse({
    required BibleModel bible,
    required VerseModel verse,
  }) {
    final chapterNumber = bible.books
        .firstWhere((book) => book.name == verse.book)
        .chapters
        .indexWhere((chapter) => chapter.number == verse.chapter);
    final chapter = bible.books
        .firstWhere((book) => book.name == verse.book)
        .chapters[chapterNumber];

    return chapter;
  }
}

BibleModel rvr1960 = BibleModel(
  id: 0,
  name: 'Reina Valera 1960',
  version: 'RVR1960',
  books: [
    genesis,
    exodo,
    levitico,
    numeros,
    deuteronomio,
    josue,
    jueces,
    rut,
    samuel1,
    samuel2,
    reyes1,
    reyes2,
    cronicas1,
    cronicas2,
    esdras,
    nehemias,
    ester,
    job,
    salmos,
    proverbios,
    eclesiastes,
    cantares,
    isaias,
    jeremias,
    lamentaciones,
    ezequiel,
    daniel,
    oseas,
    joel,
    amos,
    abdias,
    jonas,
    miqueas,
    nahum,
    habacuc,
    sofonias,
    hageo,
    zacarias,
    malaquias,
    mateo,
    marcos,
    lucas,
    juan,
    hechos,
    romanos,
    corintios1,
    corintios2,
    galatas,
    efesios,
    filipenses,
    colosenses,
    tesalonicenses1,
    tesalonicenses2,
    timoteo1,
    timoteo2,
    tito,
    filemon,
    hebreos,
    santiago,
    pedro1,
    pedro2,
    juan_1,
    juan_2,
    juan_3,
    judas,
    apocalipsis,
  ],
);
