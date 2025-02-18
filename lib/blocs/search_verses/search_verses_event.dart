import 'package:bible_app/data/data.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_verses_event.freezed.dart';

@freezed
class SearchVersesEvent with _$SearchVersesEvent {
  const factory SearchVersesEvent.initial() = SearchVersesInitialEvent;
  const factory SearchVersesEvent.search(BibleModel bible, String query) =
      SearchVersesSearchEvent;
}
