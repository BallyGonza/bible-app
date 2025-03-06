import 'package:bible_app/blocs/blocs.dart';
import 'package:bible_app/data/data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchVersesBloc extends Bloc<SearchVersesEvent, SearchVersesState> {
  SearchVersesBloc() : super(const SearchVersesState.initial()) {
    on<SearchVersesInitialEvent>(_onInit);
    on<SearchVersesSearchEvent>(_onSearch);

    add(const SearchVersesInitialEvent());
  }

  final versesRepository = VerseRepository();

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
      final verses = versesRepository.SearchVerses(event.bible, event.query);
      await Future.delayed(const Duration(milliseconds: 100));

      emit(SearchVersesState.loaded(verses: verses));
    } catch (e) {
      emit(SearchVersesState.error(e.toString()));
    }
  }
}
