import 'package:bible_app/blocs/blocs.dart';
import 'package:diacritic/diacritic.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchVersesBloc extends Bloc<SearchVersesEvent, SearchVersesState> {
  SearchVersesBloc() : super(const SearchVersesState.initial()) {
    on<SearchVersesInitialEvent>(_onInit);
    on<SearchVersesSearchEvent>(_onSearch);

    add(const SearchVersesInitialEvent());
  }

  Future<void> _onInit(
    SearchVersesInitialEvent event,
    Emitter<SearchVersesState> emit,
  ) async {
    emit(const SearchVersesState.loaded(verses: []));
  }

  Future<void> _onSearch(
    SearchVersesSearchEvent event,
    Emitter<SearchVersesState> emit,
  ) async {
    emit(const SearchVersesState.loading());

    try {
      if (event.query.isEmpty) {
        emit(const SearchVersesState.loaded(verses: []));
        return;
      }
      final verses = event.bible.books.expand((book) {
        return book.chapters.expand((chapter) {
          return chapter.verses.where((verse) {
            final verseText = removeDiacritics(verse.text.toLowerCase());
            final searchQuery = removeDiacritics(event.query.toLowerCase());
            return verseText.contains(searchQuery);
          }).map((verse) => verse.copyWith(
                book: book.name,
                chapter: chapter.number,
              ));
        });
      }).toList();
      await Future.delayed(const Duration(milliseconds: 100));

      emit(SearchVersesState.loaded(verses: verses));
    } catch (e) {
      emit(SearchVersesState.error(e.toString()));
    }
  }
}
