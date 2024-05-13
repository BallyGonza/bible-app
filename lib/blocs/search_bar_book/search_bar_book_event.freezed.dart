// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'search_bar_book_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SearchBarBookEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(UserModel user) init,
    required TResult Function(BibleModel bible, String query) search,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(UserModel user)? init,
    TResult? Function(BibleModel bible, String query)? search,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(UserModel user)? init,
    TResult Function(BibleModel bible, String query)? search,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SearchBarBookInitialEvent value) init,
    required TResult Function(SearchBarBookSearchEvent value) search,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SearchBarBookInitialEvent value)? init,
    TResult? Function(SearchBarBookSearchEvent value)? search,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SearchBarBookInitialEvent value)? init,
    TResult Function(SearchBarBookSearchEvent value)? search,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SearchBarBookEventCopyWith<$Res> {
  factory $SearchBarBookEventCopyWith(
          SearchBarBookEvent value, $Res Function(SearchBarBookEvent) then) =
      _$SearchBarBookEventCopyWithImpl<$Res, SearchBarBookEvent>;
}

/// @nodoc
class _$SearchBarBookEventCopyWithImpl<$Res, $Val extends SearchBarBookEvent>
    implements $SearchBarBookEventCopyWith<$Res> {
  _$SearchBarBookEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$SearchBarBookInitialEventImplCopyWith<$Res> {
  factory _$$SearchBarBookInitialEventImplCopyWith(
          _$SearchBarBookInitialEventImpl value,
          $Res Function(_$SearchBarBookInitialEventImpl) then) =
      __$$SearchBarBookInitialEventImplCopyWithImpl<$Res>;
  @useResult
  $Res call({UserModel user});
}

/// @nodoc
class __$$SearchBarBookInitialEventImplCopyWithImpl<$Res>
    extends _$SearchBarBookEventCopyWithImpl<$Res,
        _$SearchBarBookInitialEventImpl>
    implements _$$SearchBarBookInitialEventImplCopyWith<$Res> {
  __$$SearchBarBookInitialEventImplCopyWithImpl(
      _$SearchBarBookInitialEventImpl _value,
      $Res Function(_$SearchBarBookInitialEventImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = null,
  }) {
    return _then(_$SearchBarBookInitialEventImpl(
      null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserModel,
    ));
  }
}

/// @nodoc

class _$SearchBarBookInitialEventImpl implements SearchBarBookInitialEvent {
  const _$SearchBarBookInitialEventImpl(this.user);

  @override
  final UserModel user;

  @override
  String toString() {
    return 'SearchBarBookEvent.init(user: $user)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearchBarBookInitialEventImpl &&
            (identical(other.user, user) || other.user == user));
  }

  @override
  int get hashCode => Object.hash(runtimeType, user);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SearchBarBookInitialEventImplCopyWith<_$SearchBarBookInitialEventImpl>
      get copyWith => __$$SearchBarBookInitialEventImplCopyWithImpl<
          _$SearchBarBookInitialEventImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(UserModel user) init,
    required TResult Function(BibleModel bible, String query) search,
  }) {
    return init(user);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(UserModel user)? init,
    TResult? Function(BibleModel bible, String query)? search,
  }) {
    return init?.call(user);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(UserModel user)? init,
    TResult Function(BibleModel bible, String query)? search,
    required TResult orElse(),
  }) {
    if (init != null) {
      return init(user);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SearchBarBookInitialEvent value) init,
    required TResult Function(SearchBarBookSearchEvent value) search,
  }) {
    return init(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SearchBarBookInitialEvent value)? init,
    TResult? Function(SearchBarBookSearchEvent value)? search,
  }) {
    return init?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SearchBarBookInitialEvent value)? init,
    TResult Function(SearchBarBookSearchEvent value)? search,
    required TResult orElse(),
  }) {
    if (init != null) {
      return init(this);
    }
    return orElse();
  }
}

abstract class SearchBarBookInitialEvent implements SearchBarBookEvent {
  const factory SearchBarBookInitialEvent(final UserModel user) =
      _$SearchBarBookInitialEventImpl;

  UserModel get user;
  @JsonKey(ignore: true)
  _$$SearchBarBookInitialEventImplCopyWith<_$SearchBarBookInitialEventImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SearchBarBookSearchEventImplCopyWith<$Res> {
  factory _$$SearchBarBookSearchEventImplCopyWith(
          _$SearchBarBookSearchEventImpl value,
          $Res Function(_$SearchBarBookSearchEventImpl) then) =
      __$$SearchBarBookSearchEventImplCopyWithImpl<$Res>;
  @useResult
  $Res call({BibleModel bible, String query});
}

/// @nodoc
class __$$SearchBarBookSearchEventImplCopyWithImpl<$Res>
    extends _$SearchBarBookEventCopyWithImpl<$Res,
        _$SearchBarBookSearchEventImpl>
    implements _$$SearchBarBookSearchEventImplCopyWith<$Res> {
  __$$SearchBarBookSearchEventImplCopyWithImpl(
      _$SearchBarBookSearchEventImpl _value,
      $Res Function(_$SearchBarBookSearchEventImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bible = null,
    Object? query = null,
  }) {
    return _then(_$SearchBarBookSearchEventImpl(
      null == bible
          ? _value.bible
          : bible // ignore: cast_nullable_to_non_nullable
              as BibleModel,
      null == query
          ? _value.query
          : query // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$SearchBarBookSearchEventImpl implements SearchBarBookSearchEvent {
  const _$SearchBarBookSearchEventImpl(this.bible, this.query);

  @override
  final BibleModel bible;
  @override
  final String query;

  @override
  String toString() {
    return 'SearchBarBookEvent.search(bible: $bible, query: $query)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearchBarBookSearchEventImpl &&
            (identical(other.bible, bible) || other.bible == bible) &&
            (identical(other.query, query) || other.query == query));
  }

  @override
  int get hashCode => Object.hash(runtimeType, bible, query);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SearchBarBookSearchEventImplCopyWith<_$SearchBarBookSearchEventImpl>
      get copyWith => __$$SearchBarBookSearchEventImplCopyWithImpl<
          _$SearchBarBookSearchEventImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(UserModel user) init,
    required TResult Function(BibleModel bible, String query) search,
  }) {
    return search(bible, query);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(UserModel user)? init,
    TResult? Function(BibleModel bible, String query)? search,
  }) {
    return search?.call(bible, query);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(UserModel user)? init,
    TResult Function(BibleModel bible, String query)? search,
    required TResult orElse(),
  }) {
    if (search != null) {
      return search(bible, query);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SearchBarBookInitialEvent value) init,
    required TResult Function(SearchBarBookSearchEvent value) search,
  }) {
    return search(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SearchBarBookInitialEvent value)? init,
    TResult? Function(SearchBarBookSearchEvent value)? search,
  }) {
    return search?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SearchBarBookInitialEvent value)? init,
    TResult Function(SearchBarBookSearchEvent value)? search,
    required TResult orElse(),
  }) {
    if (search != null) {
      return search(this);
    }
    return orElse();
  }
}

abstract class SearchBarBookSearchEvent implements SearchBarBookEvent {
  const factory SearchBarBookSearchEvent(
          final BibleModel bible, final String query) =
      _$SearchBarBookSearchEventImpl;

  BibleModel get bible;
  String get query;
  @JsonKey(ignore: true)
  _$$SearchBarBookSearchEventImplCopyWith<_$SearchBarBookSearchEventImpl>
      get copyWith => throw _privateConstructorUsedError;
}
