import 'package:bible_app/data/data.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_bar_book_event.freezed.dart';

@freezed
class SearchBarBookEvent with _$SearchBarBookEvent {
  const factory SearchBarBookEvent.init(UserModel user) =
      SearchBarBookInitialEvent;
  const factory SearchBarBookEvent.search(BibleModel bible, String query) =
      SearchBarBookSearchEvent;
}
