import 'package:bible_app/blocs/blocs.dart';
import 'package:bible_app/data/data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:stream_transform/stream_transform.dart';

class SearchVersesBloc extends Bloc<SearchVersesEvent, SearchVersesState> {
  SearchVersesBloc({VerseRepository? versesRepository})
      : _versesRepository = versesRepository ?? VerseRepository(),
        super(const SearchVersesState.initial()) {
    on<SearchVersesInitialEvent>(_onInit);
    on<SearchVersesSearchEvent>(
      _onSearch,
      transformer: _debounce(const Duration(milliseconds: 250)),
    );

    add(const SearchVersesInitialEvent());
  }

  final VerseRepository _versesRepository;

  // Debounce transformer for search events to improve UX and performance
  EventTransformer<E> _debounce<E>(Duration duration) {
    return (events, mapper) => events.debounce(duration).switchMap(mapper);
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
    final query = event.query.trim();
    if (query.isEmpty) {
      emit(const SearchVersesState.loaded(verses: []));
      return;
    }

    emit(const SearchVersesState.loading());
    try {
      // Use lowerCamelCase via extension while keeping old implementation
      final verses = _versesRepository.searchVerses(event.bible, query);
      emit(SearchVersesState.loaded(verses: verses));
    } catch (e) {
      emit(SearchVersesState.error(e.toString()));
    }
  }
}
