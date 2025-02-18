import 'package:bible_app/data/data.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_verses_state.freezed.dart';

@freezed
class SearchVersesState with _$SearchVersesState {
  const factory SearchVersesState.initial() = SearchVersesInitial;
  const factory SearchVersesState.loading() = SearchVersesLoading;
  const factory SearchVersesState.loaded({required List<VerseModel> verses}) =
      SearchVersesLoaded;
  const factory SearchVersesState.error(String message) = SearchVersesError;
}
