import 'package:bible_app/blocs/search_bar_book/search_bar_book.dart';
import 'package:diacritic/diacritic.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// [SearchBarBookBloc] is responsible for managing ... related states.
class SearchBarBookBloc extends Bloc<SearchBarBookEvent, SearchBarBookState> {
  SearchBarBookBloc() : super(const SearchBarBookState.initial()) {
    on<SearchBarBookInitialEvent>(_onInit);
    on<SearchBarBookSearchEvent>(_onSearch);
  }

  Future<void> _onInit(
    SearchBarBookInitialEvent event,
    Emitter<SearchBarBookState> emit,
  ) async {
    emit(const SearchBarBookState.loading());

    try {
      emit(SearchBarBookState.loaded(books: event.user.bible.books));
    } catch (e) {
      emit(SearchBarBookState.error(e.toString()));
    }
  }

  Future<void> _onSearch(
    SearchBarBookSearchEvent event,
    Emitter<SearchBarBookState> emit,
  ) async {
    emit(const SearchBarBookState.loading());
    try {
      final books = event.bible.books
          .where(
            (book) => removeDiacritics(book.name.toLowerCase())
                .contains(removeDiacritics(event.query)),
          )
          .toList();
      emit(SearchBarBookState.loaded(books: books));
    } catch (e) {
      emit(SearchBarBookState.error(e.toString()));
    }
  }
}
