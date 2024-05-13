// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'search_bar_book_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SearchBarBookState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<BookModel> books) loaded,
    required TResult Function(String message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<BookModel> books)? loaded,
    TResult? Function(String message)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<BookModel> books)? loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SearchBarBookInitial value) initial,
    required TResult Function(SearchBarBookLoading value) loading,
    required TResult Function(SearchBarBookLoaded value) loaded,
    required TResult Function(SearchBarBookError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SearchBarBookInitial value)? initial,
    TResult? Function(SearchBarBookLoading value)? loading,
    TResult? Function(SearchBarBookLoaded value)? loaded,
    TResult? Function(SearchBarBookError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SearchBarBookInitial value)? initial,
    TResult Function(SearchBarBookLoading value)? loading,
    TResult Function(SearchBarBookLoaded value)? loaded,
    TResult Function(SearchBarBookError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SearchBarBookStateCopyWith<$Res> {
  factory $SearchBarBookStateCopyWith(
          SearchBarBookState value, $Res Function(SearchBarBookState) then) =
      _$SearchBarBookStateCopyWithImpl<$Res, SearchBarBookState>;
}

/// @nodoc
class _$SearchBarBookStateCopyWithImpl<$Res, $Val extends SearchBarBookState>
    implements $SearchBarBookStateCopyWith<$Res> {
  _$SearchBarBookStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$SearchBarBookInitialImplCopyWith<$Res> {
  factory _$$SearchBarBookInitialImplCopyWith(_$SearchBarBookInitialImpl value,
          $Res Function(_$SearchBarBookInitialImpl) then) =
      __$$SearchBarBookInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SearchBarBookInitialImplCopyWithImpl<$Res>
    extends _$SearchBarBookStateCopyWithImpl<$Res, _$SearchBarBookInitialImpl>
    implements _$$SearchBarBookInitialImplCopyWith<$Res> {
  __$$SearchBarBookInitialImplCopyWithImpl(_$SearchBarBookInitialImpl _value,
      $Res Function(_$SearchBarBookInitialImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$SearchBarBookInitialImpl implements SearchBarBookInitial {
  const _$SearchBarBookInitialImpl();

  @override
  String toString() {
    return 'SearchBarBookState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearchBarBookInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<BookModel> books) loaded,
    required TResult Function(String message) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<BookModel> books)? loaded,
    TResult? Function(String message)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<BookModel> books)? loaded,
    TResult Function(String message)? error,
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
    required TResult Function(SearchBarBookInitial value) initial,
    required TResult Function(SearchBarBookLoading value) loading,
    required TResult Function(SearchBarBookLoaded value) loaded,
    required TResult Function(SearchBarBookError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SearchBarBookInitial value)? initial,
    TResult? Function(SearchBarBookLoading value)? loading,
    TResult? Function(SearchBarBookLoaded value)? loaded,
    TResult? Function(SearchBarBookError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SearchBarBookInitial value)? initial,
    TResult Function(SearchBarBookLoading value)? loading,
    TResult Function(SearchBarBookLoaded value)? loaded,
    TResult Function(SearchBarBookError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class SearchBarBookInitial implements SearchBarBookState {
  const factory SearchBarBookInitial() = _$SearchBarBookInitialImpl;
}

/// @nodoc
abstract class _$$SearchBarBookLoadingImplCopyWith<$Res> {
  factory _$$SearchBarBookLoadingImplCopyWith(_$SearchBarBookLoadingImpl value,
          $Res Function(_$SearchBarBookLoadingImpl) then) =
      __$$SearchBarBookLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SearchBarBookLoadingImplCopyWithImpl<$Res>
    extends _$SearchBarBookStateCopyWithImpl<$Res, _$SearchBarBookLoadingImpl>
    implements _$$SearchBarBookLoadingImplCopyWith<$Res> {
  __$$SearchBarBookLoadingImplCopyWithImpl(_$SearchBarBookLoadingImpl _value,
      $Res Function(_$SearchBarBookLoadingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$SearchBarBookLoadingImpl implements SearchBarBookLoading {
  const _$SearchBarBookLoadingImpl();

  @override
  String toString() {
    return 'SearchBarBookState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearchBarBookLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<BookModel> books) loaded,
    required TResult Function(String message) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<BookModel> books)? loaded,
    TResult? Function(String message)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<BookModel> books)? loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SearchBarBookInitial value) initial,
    required TResult Function(SearchBarBookLoading value) loading,
    required TResult Function(SearchBarBookLoaded value) loaded,
    required TResult Function(SearchBarBookError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SearchBarBookInitial value)? initial,
    TResult? Function(SearchBarBookLoading value)? loading,
    TResult? Function(SearchBarBookLoaded value)? loaded,
    TResult? Function(SearchBarBookError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SearchBarBookInitial value)? initial,
    TResult Function(SearchBarBookLoading value)? loading,
    TResult Function(SearchBarBookLoaded value)? loaded,
    TResult Function(SearchBarBookError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class SearchBarBookLoading implements SearchBarBookState {
  const factory SearchBarBookLoading() = _$SearchBarBookLoadingImpl;
}

/// @nodoc
abstract class _$$SearchBarBookLoadedImplCopyWith<$Res> {
  factory _$$SearchBarBookLoadedImplCopyWith(_$SearchBarBookLoadedImpl value,
          $Res Function(_$SearchBarBookLoadedImpl) then) =
      __$$SearchBarBookLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<BookModel> books});
}

/// @nodoc
class __$$SearchBarBookLoadedImplCopyWithImpl<$Res>
    extends _$SearchBarBookStateCopyWithImpl<$Res, _$SearchBarBookLoadedImpl>
    implements _$$SearchBarBookLoadedImplCopyWith<$Res> {
  __$$SearchBarBookLoadedImplCopyWithImpl(_$SearchBarBookLoadedImpl _value,
      $Res Function(_$SearchBarBookLoadedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? books = null,
  }) {
    return _then(_$SearchBarBookLoadedImpl(
      books: null == books
          ? _value._books
          : books // ignore: cast_nullable_to_non_nullable
              as List<BookModel>,
    ));
  }
}

/// @nodoc

class _$SearchBarBookLoadedImpl implements SearchBarBookLoaded {
  const _$SearchBarBookLoadedImpl({required final List<BookModel> books})
      : _books = books;

  final List<BookModel> _books;
  @override
  List<BookModel> get books {
    if (_books is EqualUnmodifiableListView) return _books;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_books);
  }

  @override
  String toString() {
    return 'SearchBarBookState.loaded(books: $books)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearchBarBookLoadedImpl &&
            const DeepCollectionEquality().equals(other._books, _books));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_books));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SearchBarBookLoadedImplCopyWith<_$SearchBarBookLoadedImpl> get copyWith =>
      __$$SearchBarBookLoadedImplCopyWithImpl<_$SearchBarBookLoadedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<BookModel> books) loaded,
    required TResult Function(String message) error,
  }) {
    return loaded(books);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<BookModel> books)? loaded,
    TResult? Function(String message)? error,
  }) {
    return loaded?.call(books);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<BookModel> books)? loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(books);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SearchBarBookInitial value) initial,
    required TResult Function(SearchBarBookLoading value) loading,
    required TResult Function(SearchBarBookLoaded value) loaded,
    required TResult Function(SearchBarBookError value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SearchBarBookInitial value)? initial,
    TResult? Function(SearchBarBookLoading value)? loading,
    TResult? Function(SearchBarBookLoaded value)? loaded,
    TResult? Function(SearchBarBookError value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SearchBarBookInitial value)? initial,
    TResult Function(SearchBarBookLoading value)? loading,
    TResult Function(SearchBarBookLoaded value)? loaded,
    TResult Function(SearchBarBookError value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class SearchBarBookLoaded implements SearchBarBookState {
  const factory SearchBarBookLoaded({required final List<BookModel> books}) =
      _$SearchBarBookLoadedImpl;

  List<BookModel> get books;
  @JsonKey(ignore: true)
  _$$SearchBarBookLoadedImplCopyWith<_$SearchBarBookLoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SearchBarBookErrorImplCopyWith<$Res> {
  factory _$$SearchBarBookErrorImplCopyWith(_$SearchBarBookErrorImpl value,
          $Res Function(_$SearchBarBookErrorImpl) then) =
      __$$SearchBarBookErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$SearchBarBookErrorImplCopyWithImpl<$Res>
    extends _$SearchBarBookStateCopyWithImpl<$Res, _$SearchBarBookErrorImpl>
    implements _$$SearchBarBookErrorImplCopyWith<$Res> {
  __$$SearchBarBookErrorImplCopyWithImpl(_$SearchBarBookErrorImpl _value,
      $Res Function(_$SearchBarBookErrorImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$SearchBarBookErrorImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$SearchBarBookErrorImpl implements SearchBarBookError {
  const _$SearchBarBookErrorImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'SearchBarBookState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearchBarBookErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SearchBarBookErrorImplCopyWith<_$SearchBarBookErrorImpl> get copyWith =>
      __$$SearchBarBookErrorImplCopyWithImpl<_$SearchBarBookErrorImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<BookModel> books) loaded,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<BookModel> books)? loaded,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<BookModel> books)? loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SearchBarBookInitial value) initial,
    required TResult Function(SearchBarBookLoading value) loading,
    required TResult Function(SearchBarBookLoaded value) loaded,
    required TResult Function(SearchBarBookError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SearchBarBookInitial value)? initial,
    TResult? Function(SearchBarBookLoading value)? loading,
    TResult? Function(SearchBarBookLoaded value)? loaded,
    TResult? Function(SearchBarBookError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SearchBarBookInitial value)? initial,
    TResult Function(SearchBarBookLoading value)? loading,
    TResult Function(SearchBarBookLoaded value)? loaded,
    TResult Function(SearchBarBookError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class SearchBarBookError implements SearchBarBookState {
  const factory SearchBarBookError(final String message) =
      _$SearchBarBookErrorImpl;

  String get message;
  @JsonKey(ignore: true)
  _$$SearchBarBookErrorImplCopyWith<_$SearchBarBookErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
