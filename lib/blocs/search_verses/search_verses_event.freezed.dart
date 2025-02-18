// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'search_verses_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SearchVersesEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(BibleModel bible, String query) search,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(BibleModel bible, String query)? search,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(BibleModel bible, String query)? search,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SearchVersesInitialEvent value) initial,
    required TResult Function(SearchVersesSearchEvent value) search,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SearchVersesInitialEvent value)? initial,
    TResult? Function(SearchVersesSearchEvent value)? search,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SearchVersesInitialEvent value)? initial,
    TResult Function(SearchVersesSearchEvent value)? search,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SearchVersesEventCopyWith<$Res> {
  factory $SearchVersesEventCopyWith(
          SearchVersesEvent value, $Res Function(SearchVersesEvent) then) =
      _$SearchVersesEventCopyWithImpl<$Res, SearchVersesEvent>;
}

/// @nodoc
class _$SearchVersesEventCopyWithImpl<$Res, $Val extends SearchVersesEvent>
    implements $SearchVersesEventCopyWith<$Res> {
  _$SearchVersesEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SearchVersesEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$SearchVersesInitialEventImplCopyWith<$Res> {
  factory _$$SearchVersesInitialEventImplCopyWith(
          _$SearchVersesInitialEventImpl value,
          $Res Function(_$SearchVersesInitialEventImpl) then) =
      __$$SearchVersesInitialEventImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SearchVersesInitialEventImplCopyWithImpl<$Res>
    extends _$SearchVersesEventCopyWithImpl<$Res,
        _$SearchVersesInitialEventImpl>
    implements _$$SearchVersesInitialEventImplCopyWith<$Res> {
  __$$SearchVersesInitialEventImplCopyWithImpl(
      _$SearchVersesInitialEventImpl _value,
      $Res Function(_$SearchVersesInitialEventImpl) _then)
      : super(_value, _then);

  /// Create a copy of SearchVersesEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$SearchVersesInitialEventImpl implements SearchVersesInitialEvent {
  const _$SearchVersesInitialEventImpl();

  @override
  String toString() {
    return 'SearchVersesEvent.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearchVersesInitialEventImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(BibleModel bible, String query) search,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(BibleModel bible, String query)? search,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(BibleModel bible, String query)? search,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SearchVersesInitialEvent value) initial,
    required TResult Function(SearchVersesSearchEvent value) search,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SearchVersesInitialEvent value)? initial,
    TResult? Function(SearchVersesSearchEvent value)? search,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SearchVersesInitialEvent value)? initial,
    TResult Function(SearchVersesSearchEvent value)? search,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class SearchVersesInitialEvent implements SearchVersesEvent {
  const factory SearchVersesInitialEvent() = _$SearchVersesInitialEventImpl;
}

/// @nodoc
abstract class _$$SearchVersesSearchEventImplCopyWith<$Res> {
  factory _$$SearchVersesSearchEventImplCopyWith(
          _$SearchVersesSearchEventImpl value,
          $Res Function(_$SearchVersesSearchEventImpl) then) =
      __$$SearchVersesSearchEventImplCopyWithImpl<$Res>;
  @useResult
  $Res call({BibleModel bible, String query});
}

/// @nodoc
class __$$SearchVersesSearchEventImplCopyWithImpl<$Res>
    extends _$SearchVersesEventCopyWithImpl<$Res, _$SearchVersesSearchEventImpl>
    implements _$$SearchVersesSearchEventImplCopyWith<$Res> {
  __$$SearchVersesSearchEventImplCopyWithImpl(
      _$SearchVersesSearchEventImpl _value,
      $Res Function(_$SearchVersesSearchEventImpl) _then)
      : super(_value, _then);

  /// Create a copy of SearchVersesEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bible = null,
    Object? query = null,
  }) {
    return _then(_$SearchVersesSearchEventImpl(
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

class _$SearchVersesSearchEventImpl implements SearchVersesSearchEvent {
  const _$SearchVersesSearchEventImpl(this.bible, this.query);

  @override
  final BibleModel bible;
  @override
  final String query;

  @override
  String toString() {
    return 'SearchVersesEvent.search(bible: $bible, query: $query)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearchVersesSearchEventImpl &&
            (identical(other.bible, bible) || other.bible == bible) &&
            (identical(other.query, query) || other.query == query));
  }

  @override
  int get hashCode => Object.hash(runtimeType, bible, query);

  /// Create a copy of SearchVersesEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SearchVersesSearchEventImplCopyWith<_$SearchVersesSearchEventImpl>
      get copyWith => __$$SearchVersesSearchEventImplCopyWithImpl<
          _$SearchVersesSearchEventImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(BibleModel bible, String query) search,
  }) {
    return search(bible, query);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(BibleModel bible, String query)? search,
  }) {
    return search?.call(bible, query);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
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
    required TResult Function(SearchVersesInitialEvent value) initial,
    required TResult Function(SearchVersesSearchEvent value) search,
  }) {
    return search(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SearchVersesInitialEvent value)? initial,
    TResult? Function(SearchVersesSearchEvent value)? search,
  }) {
    return search?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SearchVersesInitialEvent value)? initial,
    TResult Function(SearchVersesSearchEvent value)? search,
    required TResult orElse(),
  }) {
    if (search != null) {
      return search(this);
    }
    return orElse();
  }
}

abstract class SearchVersesSearchEvent implements SearchVersesEvent {
  const factory SearchVersesSearchEvent(
          final BibleModel bible, final String query) =
      _$SearchVersesSearchEventImpl;

  BibleModel get bible;
  String get query;

  /// Create a copy of SearchVersesEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SearchVersesSearchEventImplCopyWith<_$SearchVersesSearchEventImpl>
      get copyWith => throw _privateConstructorUsedError;
}
