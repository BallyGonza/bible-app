// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notes_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$NotesEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() init,
    required TResult Function(NoteModel note) add,
    required TResult Function(int index, NoteModel note) edit,
    required TResult Function(int index) delete,
    required TResult Function(List<NoteModel> notes) deleteAll,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? init,
    TResult? Function(NoteModel note)? add,
    TResult? Function(int index, NoteModel note)? edit,
    TResult? Function(int index)? delete,
    TResult? Function(List<NoteModel> notes)? deleteAll,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? init,
    TResult Function(NoteModel note)? add,
    TResult Function(int index, NoteModel note)? edit,
    TResult Function(int index)? delete,
    TResult Function(List<NoteModel> notes)? deleteAll,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NotesInitialEvent value) init,
    required TResult Function(NotesAddEvent value) add,
    required TResult Function(NotesEditEvent value) edit,
    required TResult Function(NotesDeleteEvent value) delete,
    required TResult Function(NotesDeleteAllEvent value) deleteAll,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NotesInitialEvent value)? init,
    TResult? Function(NotesAddEvent value)? add,
    TResult? Function(NotesEditEvent value)? edit,
    TResult? Function(NotesDeleteEvent value)? delete,
    TResult? Function(NotesDeleteAllEvent value)? deleteAll,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NotesInitialEvent value)? init,
    TResult Function(NotesAddEvent value)? add,
    TResult Function(NotesEditEvent value)? edit,
    TResult Function(NotesDeleteEvent value)? delete,
    TResult Function(NotesDeleteAllEvent value)? deleteAll,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotesEventCopyWith<$Res> {
  factory $NotesEventCopyWith(
          NotesEvent value, $Res Function(NotesEvent) then) =
      _$NotesEventCopyWithImpl<$Res, NotesEvent>;
}

/// @nodoc
class _$NotesEventCopyWithImpl<$Res, $Val extends NotesEvent>
    implements $NotesEventCopyWith<$Res> {
  _$NotesEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$NotesInitialEventImplCopyWith<$Res> {
  factory _$$NotesInitialEventImplCopyWith(_$NotesInitialEventImpl value,
          $Res Function(_$NotesInitialEventImpl) then) =
      __$$NotesInitialEventImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$NotesInitialEventImplCopyWithImpl<$Res>
    extends _$NotesEventCopyWithImpl<$Res, _$NotesInitialEventImpl>
    implements _$$NotesInitialEventImplCopyWith<$Res> {
  __$$NotesInitialEventImplCopyWithImpl(_$NotesInitialEventImpl _value,
      $Res Function(_$NotesInitialEventImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$NotesInitialEventImpl implements NotesInitialEvent {
  const _$NotesInitialEventImpl();

  @override
  String toString() {
    return 'NotesEvent.init()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$NotesInitialEventImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() init,
    required TResult Function(NoteModel note) add,
    required TResult Function(int index, NoteModel note) edit,
    required TResult Function(int index) delete,
    required TResult Function(List<NoteModel> notes) deleteAll,
  }) {
    return init();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? init,
    TResult? Function(NoteModel note)? add,
    TResult? Function(int index, NoteModel note)? edit,
    TResult? Function(int index)? delete,
    TResult? Function(List<NoteModel> notes)? deleteAll,
  }) {
    return init?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? init,
    TResult Function(NoteModel note)? add,
    TResult Function(int index, NoteModel note)? edit,
    TResult Function(int index)? delete,
    TResult Function(List<NoteModel> notes)? deleteAll,
    required TResult orElse(),
  }) {
    if (init != null) {
      return init();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NotesInitialEvent value) init,
    required TResult Function(NotesAddEvent value) add,
    required TResult Function(NotesEditEvent value) edit,
    required TResult Function(NotesDeleteEvent value) delete,
    required TResult Function(NotesDeleteAllEvent value) deleteAll,
  }) {
    return init(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NotesInitialEvent value)? init,
    TResult? Function(NotesAddEvent value)? add,
    TResult? Function(NotesEditEvent value)? edit,
    TResult? Function(NotesDeleteEvent value)? delete,
    TResult? Function(NotesDeleteAllEvent value)? deleteAll,
  }) {
    return init?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NotesInitialEvent value)? init,
    TResult Function(NotesAddEvent value)? add,
    TResult Function(NotesEditEvent value)? edit,
    TResult Function(NotesDeleteEvent value)? delete,
    TResult Function(NotesDeleteAllEvent value)? deleteAll,
    required TResult orElse(),
  }) {
    if (init != null) {
      return init(this);
    }
    return orElse();
  }
}

abstract class NotesInitialEvent implements NotesEvent {
  const factory NotesInitialEvent() = _$NotesInitialEventImpl;
}

/// @nodoc
abstract class _$$NotesAddEventImplCopyWith<$Res> {
  factory _$$NotesAddEventImplCopyWith(
          _$NotesAddEventImpl value, $Res Function(_$NotesAddEventImpl) then) =
      __$$NotesAddEventImplCopyWithImpl<$Res>;
  @useResult
  $Res call({NoteModel note});
}

/// @nodoc
class __$$NotesAddEventImplCopyWithImpl<$Res>
    extends _$NotesEventCopyWithImpl<$Res, _$NotesAddEventImpl>
    implements _$$NotesAddEventImplCopyWith<$Res> {
  __$$NotesAddEventImplCopyWithImpl(
      _$NotesAddEventImpl _value, $Res Function(_$NotesAddEventImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? note = null,
  }) {
    return _then(_$NotesAddEventImpl(
      null == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as NoteModel,
    ));
  }
}

/// @nodoc

class _$NotesAddEventImpl implements NotesAddEvent {
  const _$NotesAddEventImpl(this.note);

  @override
  final NoteModel note;

  @override
  String toString() {
    return 'NotesEvent.add(note: $note)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotesAddEventImpl &&
            (identical(other.note, note) || other.note == note));
  }

  @override
  int get hashCode => Object.hash(runtimeType, note);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NotesAddEventImplCopyWith<_$NotesAddEventImpl> get copyWith =>
      __$$NotesAddEventImplCopyWithImpl<_$NotesAddEventImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() init,
    required TResult Function(NoteModel note) add,
    required TResult Function(int index, NoteModel note) edit,
    required TResult Function(int index) delete,
    required TResult Function(List<NoteModel> notes) deleteAll,
  }) {
    return add(note);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? init,
    TResult? Function(NoteModel note)? add,
    TResult? Function(int index, NoteModel note)? edit,
    TResult? Function(int index)? delete,
    TResult? Function(List<NoteModel> notes)? deleteAll,
  }) {
    return add?.call(note);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? init,
    TResult Function(NoteModel note)? add,
    TResult Function(int index, NoteModel note)? edit,
    TResult Function(int index)? delete,
    TResult Function(List<NoteModel> notes)? deleteAll,
    required TResult orElse(),
  }) {
    if (add != null) {
      return add(note);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NotesInitialEvent value) init,
    required TResult Function(NotesAddEvent value) add,
    required TResult Function(NotesEditEvent value) edit,
    required TResult Function(NotesDeleteEvent value) delete,
    required TResult Function(NotesDeleteAllEvent value) deleteAll,
  }) {
    return add(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NotesInitialEvent value)? init,
    TResult? Function(NotesAddEvent value)? add,
    TResult? Function(NotesEditEvent value)? edit,
    TResult? Function(NotesDeleteEvent value)? delete,
    TResult? Function(NotesDeleteAllEvent value)? deleteAll,
  }) {
    return add?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NotesInitialEvent value)? init,
    TResult Function(NotesAddEvent value)? add,
    TResult Function(NotesEditEvent value)? edit,
    TResult Function(NotesDeleteEvent value)? delete,
    TResult Function(NotesDeleteAllEvent value)? deleteAll,
    required TResult orElse(),
  }) {
    if (add != null) {
      return add(this);
    }
    return orElse();
  }
}

abstract class NotesAddEvent implements NotesEvent {
  const factory NotesAddEvent(final NoteModel note) = _$NotesAddEventImpl;

  NoteModel get note;
  @JsonKey(ignore: true)
  _$$NotesAddEventImplCopyWith<_$NotesAddEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$NotesEditEventImplCopyWith<$Res> {
  factory _$$NotesEditEventImplCopyWith(_$NotesEditEventImpl value,
          $Res Function(_$NotesEditEventImpl) then) =
      __$$NotesEditEventImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int index, NoteModel note});
}

/// @nodoc
class __$$NotesEditEventImplCopyWithImpl<$Res>
    extends _$NotesEventCopyWithImpl<$Res, _$NotesEditEventImpl>
    implements _$$NotesEditEventImplCopyWith<$Res> {
  __$$NotesEditEventImplCopyWithImpl(
      _$NotesEditEventImpl _value, $Res Function(_$NotesEditEventImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? index = null,
    Object? note = null,
  }) {
    return _then(_$NotesEditEventImpl(
      null == index
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
      null == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as NoteModel,
    ));
  }
}

/// @nodoc

class _$NotesEditEventImpl implements NotesEditEvent {
  const _$NotesEditEventImpl(this.index, this.note);

  @override
  final int index;
  @override
  final NoteModel note;

  @override
  String toString() {
    return 'NotesEvent.edit(index: $index, note: $note)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotesEditEventImpl &&
            (identical(other.index, index) || other.index == index) &&
            (identical(other.note, note) || other.note == note));
  }

  @override
  int get hashCode => Object.hash(runtimeType, index, note);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NotesEditEventImplCopyWith<_$NotesEditEventImpl> get copyWith =>
      __$$NotesEditEventImplCopyWithImpl<_$NotesEditEventImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() init,
    required TResult Function(NoteModel note) add,
    required TResult Function(int index, NoteModel note) edit,
    required TResult Function(int index) delete,
    required TResult Function(List<NoteModel> notes) deleteAll,
  }) {
    return edit(index, note);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? init,
    TResult? Function(NoteModel note)? add,
    TResult? Function(int index, NoteModel note)? edit,
    TResult? Function(int index)? delete,
    TResult? Function(List<NoteModel> notes)? deleteAll,
  }) {
    return edit?.call(index, note);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? init,
    TResult Function(NoteModel note)? add,
    TResult Function(int index, NoteModel note)? edit,
    TResult Function(int index)? delete,
    TResult Function(List<NoteModel> notes)? deleteAll,
    required TResult orElse(),
  }) {
    if (edit != null) {
      return edit(index, note);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NotesInitialEvent value) init,
    required TResult Function(NotesAddEvent value) add,
    required TResult Function(NotesEditEvent value) edit,
    required TResult Function(NotesDeleteEvent value) delete,
    required TResult Function(NotesDeleteAllEvent value) deleteAll,
  }) {
    return edit(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NotesInitialEvent value)? init,
    TResult? Function(NotesAddEvent value)? add,
    TResult? Function(NotesEditEvent value)? edit,
    TResult? Function(NotesDeleteEvent value)? delete,
    TResult? Function(NotesDeleteAllEvent value)? deleteAll,
  }) {
    return edit?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NotesInitialEvent value)? init,
    TResult Function(NotesAddEvent value)? add,
    TResult Function(NotesEditEvent value)? edit,
    TResult Function(NotesDeleteEvent value)? delete,
    TResult Function(NotesDeleteAllEvent value)? deleteAll,
    required TResult orElse(),
  }) {
    if (edit != null) {
      return edit(this);
    }
    return orElse();
  }
}

abstract class NotesEditEvent implements NotesEvent {
  const factory NotesEditEvent(final int index, final NoteModel note) =
      _$NotesEditEventImpl;

  int get index;
  NoteModel get note;
  @JsonKey(ignore: true)
  _$$NotesEditEventImplCopyWith<_$NotesEditEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$NotesDeleteEventImplCopyWith<$Res> {
  factory _$$NotesDeleteEventImplCopyWith(_$NotesDeleteEventImpl value,
          $Res Function(_$NotesDeleteEventImpl) then) =
      __$$NotesDeleteEventImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int index});
}

/// @nodoc
class __$$NotesDeleteEventImplCopyWithImpl<$Res>
    extends _$NotesEventCopyWithImpl<$Res, _$NotesDeleteEventImpl>
    implements _$$NotesDeleteEventImplCopyWith<$Res> {
  __$$NotesDeleteEventImplCopyWithImpl(_$NotesDeleteEventImpl _value,
      $Res Function(_$NotesDeleteEventImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? index = null,
  }) {
    return _then(_$NotesDeleteEventImpl(
      null == index
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$NotesDeleteEventImpl implements NotesDeleteEvent {
  const _$NotesDeleteEventImpl(this.index);

  @override
  final int index;

  @override
  String toString() {
    return 'NotesEvent.delete(index: $index)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotesDeleteEventImpl &&
            (identical(other.index, index) || other.index == index));
  }

  @override
  int get hashCode => Object.hash(runtimeType, index);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NotesDeleteEventImplCopyWith<_$NotesDeleteEventImpl> get copyWith =>
      __$$NotesDeleteEventImplCopyWithImpl<_$NotesDeleteEventImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() init,
    required TResult Function(NoteModel note) add,
    required TResult Function(int index, NoteModel note) edit,
    required TResult Function(int index) delete,
    required TResult Function(List<NoteModel> notes) deleteAll,
  }) {
    return delete(index);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? init,
    TResult? Function(NoteModel note)? add,
    TResult? Function(int index, NoteModel note)? edit,
    TResult? Function(int index)? delete,
    TResult? Function(List<NoteModel> notes)? deleteAll,
  }) {
    return delete?.call(index);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? init,
    TResult Function(NoteModel note)? add,
    TResult Function(int index, NoteModel note)? edit,
    TResult Function(int index)? delete,
    TResult Function(List<NoteModel> notes)? deleteAll,
    required TResult orElse(),
  }) {
    if (delete != null) {
      return delete(index);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NotesInitialEvent value) init,
    required TResult Function(NotesAddEvent value) add,
    required TResult Function(NotesEditEvent value) edit,
    required TResult Function(NotesDeleteEvent value) delete,
    required TResult Function(NotesDeleteAllEvent value) deleteAll,
  }) {
    return delete(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NotesInitialEvent value)? init,
    TResult? Function(NotesAddEvent value)? add,
    TResult? Function(NotesEditEvent value)? edit,
    TResult? Function(NotesDeleteEvent value)? delete,
    TResult? Function(NotesDeleteAllEvent value)? deleteAll,
  }) {
    return delete?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NotesInitialEvent value)? init,
    TResult Function(NotesAddEvent value)? add,
    TResult Function(NotesEditEvent value)? edit,
    TResult Function(NotesDeleteEvent value)? delete,
    TResult Function(NotesDeleteAllEvent value)? deleteAll,
    required TResult orElse(),
  }) {
    if (delete != null) {
      return delete(this);
    }
    return orElse();
  }
}

abstract class NotesDeleteEvent implements NotesEvent {
  const factory NotesDeleteEvent(final int index) = _$NotesDeleteEventImpl;

  int get index;
  @JsonKey(ignore: true)
  _$$NotesDeleteEventImplCopyWith<_$NotesDeleteEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$NotesDeleteAllEventImplCopyWith<$Res> {
  factory _$$NotesDeleteAllEventImplCopyWith(_$NotesDeleteAllEventImpl value,
          $Res Function(_$NotesDeleteAllEventImpl) then) =
      __$$NotesDeleteAllEventImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<NoteModel> notes});
}

/// @nodoc
class __$$NotesDeleteAllEventImplCopyWithImpl<$Res>
    extends _$NotesEventCopyWithImpl<$Res, _$NotesDeleteAllEventImpl>
    implements _$$NotesDeleteAllEventImplCopyWith<$Res> {
  __$$NotesDeleteAllEventImplCopyWithImpl(_$NotesDeleteAllEventImpl _value,
      $Res Function(_$NotesDeleteAllEventImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? notes = null,
  }) {
    return _then(_$NotesDeleteAllEventImpl(
      null == notes
          ? _value._notes
          : notes // ignore: cast_nullable_to_non_nullable
              as List<NoteModel>,
    ));
  }
}

/// @nodoc

class _$NotesDeleteAllEventImpl implements NotesDeleteAllEvent {
  const _$NotesDeleteAllEventImpl(final List<NoteModel> notes) : _notes = notes;

  final List<NoteModel> _notes;
  @override
  List<NoteModel> get notes {
    if (_notes is EqualUnmodifiableListView) return _notes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_notes);
  }

  @override
  String toString() {
    return 'NotesEvent.deleteAll(notes: $notes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotesDeleteAllEventImpl &&
            const DeepCollectionEquality().equals(other._notes, _notes));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_notes));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NotesDeleteAllEventImplCopyWith<_$NotesDeleteAllEventImpl> get copyWith =>
      __$$NotesDeleteAllEventImplCopyWithImpl<_$NotesDeleteAllEventImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() init,
    required TResult Function(NoteModel note) add,
    required TResult Function(int index, NoteModel note) edit,
    required TResult Function(int index) delete,
    required TResult Function(List<NoteModel> notes) deleteAll,
  }) {
    return deleteAll(notes);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? init,
    TResult? Function(NoteModel note)? add,
    TResult? Function(int index, NoteModel note)? edit,
    TResult? Function(int index)? delete,
    TResult? Function(List<NoteModel> notes)? deleteAll,
  }) {
    return deleteAll?.call(notes);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? init,
    TResult Function(NoteModel note)? add,
    TResult Function(int index, NoteModel note)? edit,
    TResult Function(int index)? delete,
    TResult Function(List<NoteModel> notes)? deleteAll,
    required TResult orElse(),
  }) {
    if (deleteAll != null) {
      return deleteAll(notes);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NotesInitialEvent value) init,
    required TResult Function(NotesAddEvent value) add,
    required TResult Function(NotesEditEvent value) edit,
    required TResult Function(NotesDeleteEvent value) delete,
    required TResult Function(NotesDeleteAllEvent value) deleteAll,
  }) {
    return deleteAll(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NotesInitialEvent value)? init,
    TResult? Function(NotesAddEvent value)? add,
    TResult? Function(NotesEditEvent value)? edit,
    TResult? Function(NotesDeleteEvent value)? delete,
    TResult? Function(NotesDeleteAllEvent value)? deleteAll,
  }) {
    return deleteAll?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NotesInitialEvent value)? init,
    TResult Function(NotesAddEvent value)? add,
    TResult Function(NotesEditEvent value)? edit,
    TResult Function(NotesDeleteEvent value)? delete,
    TResult Function(NotesDeleteAllEvent value)? deleteAll,
    required TResult orElse(),
  }) {
    if (deleteAll != null) {
      return deleteAll(this);
    }
    return orElse();
  }
}

abstract class NotesDeleteAllEvent implements NotesEvent {
  const factory NotesDeleteAllEvent(final List<NoteModel> notes) =
      _$NotesDeleteAllEventImpl;

  List<NoteModel> get notes;
  @JsonKey(ignore: true)
  _$$NotesDeleteAllEventImplCopyWith<_$NotesDeleteAllEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
