import 'package:bible_app/data/data.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_bar_book_state.freezed.dart';

@freezed
class SearchBarBookState with _$SearchBarBookState {
  const factory SearchBarBookState.initial() = SearchBarBookInitial;
  const factory SearchBarBookState.loading() = SearchBarBookLoading;
  const factory SearchBarBookState.loaded({required List<BookModel> books}) =
      SearchBarBookLoaded;
  const factory SearchBarBookState.error(String message) = SearchBarBookError;
}
