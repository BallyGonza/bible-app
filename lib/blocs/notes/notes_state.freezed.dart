// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notes_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$NotesState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<NoteModel> notes) loaded,
    required TResult Function() failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<NoteModel> notes)? loaded,
    TResult? Function()? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<NoteModel> notes)? loaded,
    TResult Function()? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NotesInitial value) initial,
    required TResult Function(NotesLoading value) loading,
    required TResult Function(NotesLoaded value) loaded,
    required TResult Function(NotesFailure value) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NotesInitial value)? initial,
    TResult? Function(NotesLoading value)? loading,
    TResult? Function(NotesLoaded value)? loaded,
    TResult? Function(NotesFailure value)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NotesInitial value)? initial,
    TResult Function(NotesLoading value)? loading,
    TResult Function(NotesLoaded value)? loaded,
    TResult Function(NotesFailure value)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotesStateCopyWith<$Res> {
  factory $NotesStateCopyWith(
          NotesState value, $Res Function(NotesState) then) =
      _$NotesStateCopyWithImpl<$Res, NotesState>;
}

/// @nodoc
class _$NotesStateCopyWithImpl<$Res, $Val extends NotesState>
    implements $NotesStateCopyWith<$Res> {
  _$NotesStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NotesState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$NotesInitialImplCopyWith<$Res> {
  factory _$$NotesInitialImplCopyWith(
          _$NotesInitialImpl value, $Res Function(_$NotesInitialImpl) then) =
      __$$NotesInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$NotesInitialImplCopyWithImpl<$Res>
    extends _$NotesStateCopyWithImpl<$Res, _$NotesInitialImpl>
    implements _$$NotesInitialImplCopyWith<$Res> {
  __$$NotesInitialImplCopyWithImpl(
      _$NotesInitialImpl _value, $Res Function(_$NotesInitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of NotesState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$NotesInitialImpl implements NotesInitial {
  const _$NotesInitialImpl();

  @override
  String toString() {
    return 'NotesState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$NotesInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<NoteModel> notes) loaded,
    required TResult Function() failure,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<NoteModel> notes)? loaded,
    TResult? Function()? failure,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<NoteModel> notes)? loaded,
    TResult Function()? failure,
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
    required TResult Function(NotesInitial value) initial,
    required TResult Function(NotesLoading value) loading,
    required TResult Function(NotesLoaded value) loaded,
    required TResult Function(NotesFailure value) failure,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NotesInitial value)? initial,
    TResult? Function(NotesLoading value)? loading,
    TResult? Function(NotesLoaded value)? loaded,
    TResult? Function(NotesFailure value)? failure,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NotesInitial value)? initial,
    TResult Function(NotesLoading value)? loading,
    TResult Function(NotesLoaded value)? loaded,
    TResult Function(NotesFailure value)? failure,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class NotesInitial implements NotesState {
  const factory NotesInitial() = _$NotesInitialImpl;
}

/// @nodoc
abstract class _$$NotesLoadingImplCopyWith<$Res> {
  factory _$$NotesLoadingImplCopyWith(
          _$NotesLoadingImpl value, $Res Function(_$NotesLoadingImpl) then) =
      __$$NotesLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$NotesLoadingImplCopyWithImpl<$Res>
    extends _$NotesStateCopyWithImpl<$Res, _$NotesLoadingImpl>
    implements _$$NotesLoadingImplCopyWith<$Res> {
  __$$NotesLoadingImplCopyWithImpl(
      _$NotesLoadingImpl _value, $Res Function(_$NotesLoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of NotesState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$NotesLoadingImpl implements NotesLoading {
  const _$NotesLoadingImpl();

  @override
  String toString() {
    return 'NotesState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$NotesLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<NoteModel> notes) loaded,
    required TResult Function() failure,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<NoteModel> notes)? loaded,
    TResult? Function()? failure,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<NoteModel> notes)? loaded,
    TResult Function()? failure,
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
    required TResult Function(NotesInitial value) initial,
    required TResult Function(NotesLoading value) loading,
    required TResult Function(NotesLoaded value) loaded,
    required TResult Function(NotesFailure value) failure,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NotesInitial value)? initial,
    TResult? Function(NotesLoading value)? loading,
    TResult? Function(NotesLoaded value)? loaded,
    TResult? Function(NotesFailure value)? failure,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NotesInitial value)? initial,
    TResult Function(NotesLoading value)? loading,
    TResult Function(NotesLoaded value)? loaded,
    TResult Function(NotesFailure value)? failure,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class NotesLoading implements NotesState {
  const factory NotesLoading() = _$NotesLoadingImpl;
}

/// @nodoc
abstract class _$$NotesLoadedImplCopyWith<$Res> {
  factory _$$NotesLoadedImplCopyWith(
          _$NotesLoadedImpl value, $Res Function(_$NotesLoadedImpl) then) =
      __$$NotesLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<NoteModel> notes});
}

/// @nodoc
class __$$NotesLoadedImplCopyWithImpl<$Res>
    extends _$NotesStateCopyWithImpl<$Res, _$NotesLoadedImpl>
    implements _$$NotesLoadedImplCopyWith<$Res> {
  __$$NotesLoadedImplCopyWithImpl(
      _$NotesLoadedImpl _value, $Res Function(_$NotesLoadedImpl) _then)
      : super(_value, _then);

  /// Create a copy of NotesState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? notes = null,
  }) {
    return _then(_$NotesLoadedImpl(
      null == notes
          ? _value._notes
          : notes // ignore: cast_nullable_to_non_nullable
              as List<NoteModel>,
    ));
  }
}

/// @nodoc

class _$NotesLoadedImpl implements NotesLoaded {
  const _$NotesLoadedImpl(final List<NoteModel> notes) : _notes = notes;

  final List<NoteModel> _notes;
  @override
  List<NoteModel> get notes {
    if (_notes is EqualUnmodifiableListView) return _notes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_notes);
  }

  @override
  String toString() {
    return 'NotesState.loaded(notes: $notes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotesLoadedImpl &&
            const DeepCollectionEquality().equals(other._notes, _notes));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_notes));

  /// Create a copy of NotesState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NotesLoadedImplCopyWith<_$NotesLoadedImpl> get copyWith =>
      __$$NotesLoadedImplCopyWithImpl<_$NotesLoadedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<NoteModel> notes) loaded,
    required TResult Function() failure,
  }) {
    return loaded(notes);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<NoteModel> notes)? loaded,
    TResult? Function()? failure,
  }) {
    return loaded?.call(notes);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<NoteModel> notes)? loaded,
    TResult Function()? failure,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(notes);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NotesInitial value) initial,
    required TResult Function(NotesLoading value) loading,
    required TResult Function(NotesLoaded value) loaded,
    required TResult Function(NotesFailure value) failure,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NotesInitial value)? initial,
    TResult? Function(NotesLoading value)? loading,
    TResult? Function(NotesLoaded value)? loaded,
    TResult? Function(NotesFailure value)? failure,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NotesInitial value)? initial,
    TResult Function(NotesLoading value)? loading,
    TResult Function(NotesLoaded value)? loaded,
    TResult Function(NotesFailure value)? failure,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class NotesLoaded implements NotesState {
  const factory NotesLoaded(final List<NoteModel> notes) = _$NotesLoadedImpl;

  List<NoteModel> get notes;

  /// Create a copy of NotesState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NotesLoadedImplCopyWith<_$NotesLoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$NotesFailureImplCopyWith<$Res> {
  factory _$$NotesFailureImplCopyWith(
          _$NotesFailureImpl value, $Res Function(_$NotesFailureImpl) then) =
      __$$NotesFailureImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$NotesFailureImplCopyWithImpl<$Res>
    extends _$NotesStateCopyWithImpl<$Res, _$NotesFailureImpl>
    implements _$$NotesFailureImplCopyWith<$Res> {
  __$$NotesFailureImplCopyWithImpl(
      _$NotesFailureImpl _value, $Res Function(_$NotesFailureImpl) _then)
      : super(_value, _then);

  /// Create a copy of NotesState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$NotesFailureImpl implements NotesFailure {
  const _$NotesFailureImpl();

  @override
  String toString() {
    return 'NotesState.failure()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$NotesFailureImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<NoteModel> notes) loaded,
    required TResult Function() failure,
  }) {
    return failure();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<NoteModel> notes)? loaded,
    TResult? Function()? failure,
  }) {
    return failure?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<NoteModel> notes)? loaded,
    TResult Function()? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NotesInitial value) initial,
    required TResult Function(NotesLoading value) loading,
    required TResult Function(NotesLoaded value) loaded,
    required TResult Function(NotesFailure value) failure,
  }) {
    return failure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NotesInitial value)? initial,
    TResult? Function(NotesLoading value)? loading,
    TResult? Function(NotesLoaded value)? loaded,
    TResult? Function(NotesFailure value)? failure,
  }) {
    return failure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NotesInitial value)? initial,
    TResult Function(NotesLoading value)? loading,
    TResult Function(NotesLoaded value)? loaded,
    TResult Function(NotesFailure value)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(this);
    }
    return orElse();
  }
}

abstract class NotesFailure implements NotesState {
  const factory NotesFailure() = _$NotesFailureImpl;
}
