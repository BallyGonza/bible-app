import 'dart:async';
import 'package:bible_app/blocs/search_bar_book/search_bar_book.dart';
import 'package:bible_app/data/data.dart';
import 'package:diacritic/diacritic.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// [SearchBarBookBloc] manages book search functionality with diacritic-insensitive filtering
class SearchBarBookBloc extends Bloc<SearchBarBookEvent, SearchBarBookState> {
  SearchBarBookBloc() : super(const SearchBarBookState.initial()) {
    on<SearchBarBookInitialEvent>(_onInit);
    on<SearchBarBookSearchEvent>(
      _onSearch,
      transformer: _debounceTransformer(const Duration(milliseconds: 300)),
    );
  }

  // Cache for normalized book names to improve search performance
  final Map<BookModel, String> _normalizedBookNames = {};
  List<BookModel> _allBooks = [];

  /// Debounce transformer to prevent excessive search events
  EventTransformer<T> _debounceTransformer<T>(Duration duration) {
    return (events, mapper) {
      return events
          .distinct()
          .asyncExpand((event) async* {
            await Future.delayed(duration);
            yield* mapper(event);
          });
    };
  }

  Future<void> _onInit(
    SearchBarBookInitialEvent event,
    Emitter<SearchBarBookState> emit,
  ) async {
    emit(const SearchBarBookState.loading());

    try {
      _allBooks = event.user.bible.books;
      _precomputeNormalizedNames(_allBooks);
      emit(SearchBarBookState.loaded(books: _allBooks));
    } catch (e) {
      emit(SearchBarBookState.error(e.toString()));
    }
  }

  Future<void> _onSearch(
    SearchBarBookSearchEvent event,
    Emitter<SearchBarBookState> emit,
  ) async {
    try {
      final filteredBooks = _performSearch(_allBooks, event.query);
      emit(SearchBarBookState.loaded(books: filteredBooks));
    } catch (e) {
      emit(SearchBarBookState.error(e.toString()));
    }
  }

  /// Precomputes normalized book names for better search performance
  void _precomputeNormalizedNames(List<BookModel> books) {
    _normalizedBookNames.clear();
    for (final book in books) {
      _normalizedBookNames[book] = _normalizeText(book.name);
    }
  }

  /// Performs the actual search with optimized string matching
  List<BookModel> _performSearch(List<BookModel> books, String query) {
    if (query.trim().isEmpty) {
      return books;
    }

    final normalizedQuery = _normalizeText(query);
    
    return books.where((book) {
      final normalizedBookName = _normalizedBookNames[book] ?? _normalizeText(book.name);
      return normalizedBookName.contains(normalizedQuery);
    }).toList();
  }

  /// Normalizes text by removing diacritics and converting to lowercase
  String _normalizeText(String text) {
    return removeDiacritics(text.toLowerCase().trim());
  }

  @override
  Future<void> close() {
    _normalizedBookNames.clear();
    return super.close();
  }
}
