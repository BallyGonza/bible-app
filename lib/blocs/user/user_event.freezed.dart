// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$UserEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() init,
    required TResult Function(VerseModel verse) saveVerse,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? init,
    TResult? Function(VerseModel verse)? saveVerse,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? init,
    TResult Function(VerseModel verse)? saveVerse,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(UserInitialEvent value) init,
    required TResult Function(UserSaveEvent value) saveVerse,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(UserInitialEvent value)? init,
    TResult? Function(UserSaveEvent value)? saveVerse,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UserInitialEvent value)? init,
    TResult Function(UserSaveEvent value)? saveVerse,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserEventCopyWith<$Res> {
  factory $UserEventCopyWith(UserEvent value, $Res Function(UserEvent) then) =
      _$UserEventCopyWithImpl<$Res, UserEvent>;
}

/// @nodoc
class _$UserEventCopyWithImpl<$Res, $Val extends UserEvent>
    implements $UserEventCopyWith<$Res> {
  _$UserEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$UserInitialEventImplCopyWith<$Res> {
  factory _$$UserInitialEventImplCopyWith(_$UserInitialEventImpl value,
          $Res Function(_$UserInitialEventImpl) then) =
      __$$UserInitialEventImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$UserInitialEventImplCopyWithImpl<$Res>
    extends _$UserEventCopyWithImpl<$Res, _$UserInitialEventImpl>
    implements _$$UserInitialEventImplCopyWith<$Res> {
  __$$UserInitialEventImplCopyWithImpl(_$UserInitialEventImpl _value,
      $Res Function(_$UserInitialEventImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$UserInitialEventImpl implements UserInitialEvent {
  const _$UserInitialEventImpl();

  @override
  String toString() {
    return 'UserEvent.init()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$UserInitialEventImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() init,
    required TResult Function(VerseModel verse) saveVerse,
  }) {
    return init();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? init,
    TResult? Function(VerseModel verse)? saveVerse,
  }) {
    return init?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? init,
    TResult Function(VerseModel verse)? saveVerse,
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
    required TResult Function(UserInitialEvent value) init,
    required TResult Function(UserSaveEvent value) saveVerse,
  }) {
    return init(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(UserInitialEvent value)? init,
    TResult? Function(UserSaveEvent value)? saveVerse,
  }) {
    return init?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UserInitialEvent value)? init,
    TResult Function(UserSaveEvent value)? saveVerse,
    required TResult orElse(),
  }) {
    if (init != null) {
      return init(this);
    }
    return orElse();
  }
}

abstract class UserInitialEvent implements UserEvent {
  const factory UserInitialEvent() = _$UserInitialEventImpl;
}

/// @nodoc
abstract class _$$UserSaveEventImplCopyWith<$Res> {
  factory _$$UserSaveEventImplCopyWith(
          _$UserSaveEventImpl value, $Res Function(_$UserSaveEventImpl) then) =
      __$$UserSaveEventImplCopyWithImpl<$Res>;
  @useResult
  $Res call({VerseModel verse});
}

/// @nodoc
class __$$UserSaveEventImplCopyWithImpl<$Res>
    extends _$UserEventCopyWithImpl<$Res, _$UserSaveEventImpl>
    implements _$$UserSaveEventImplCopyWith<$Res> {
  __$$UserSaveEventImplCopyWithImpl(
      _$UserSaveEventImpl _value, $Res Function(_$UserSaveEventImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? verse = null,
  }) {
    return _then(_$UserSaveEventImpl(
      verse: null == verse
          ? _value.verse
          : verse // ignore: cast_nullable_to_non_nullable
              as VerseModel,
    ));
  }
}

/// @nodoc

class _$UserSaveEventImpl implements UserSaveEvent {
  const _$UserSaveEventImpl({required this.verse});

  @override
  final VerseModel verse;

  @override
  String toString() {
    return 'UserEvent.saveVerse(verse: $verse)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserSaveEventImpl &&
            (identical(other.verse, verse) || other.verse == verse));
  }

  @override
  int get hashCode => Object.hash(runtimeType, verse);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserSaveEventImplCopyWith<_$UserSaveEventImpl> get copyWith =>
      __$$UserSaveEventImplCopyWithImpl<_$UserSaveEventImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() init,
    required TResult Function(VerseModel verse) saveVerse,
  }) {
    return saveVerse(verse);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? init,
    TResult? Function(VerseModel verse)? saveVerse,
  }) {
    return saveVerse?.call(verse);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? init,
    TResult Function(VerseModel verse)? saveVerse,
    required TResult orElse(),
  }) {
    if (saveVerse != null) {
      return saveVerse(verse);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(UserInitialEvent value) init,
    required TResult Function(UserSaveEvent value) saveVerse,
  }) {
    return saveVerse(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(UserInitialEvent value)? init,
    TResult? Function(UserSaveEvent value)? saveVerse,
  }) {
    return saveVerse?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UserInitialEvent value)? init,
    TResult Function(UserSaveEvent value)? saveVerse,
    required TResult orElse(),
  }) {
    if (saveVerse != null) {
      return saveVerse(this);
    }
    return orElse();
  }
}

abstract class UserSaveEvent implements UserEvent {
  const factory UserSaveEvent({required final VerseModel verse}) =
      _$UserSaveEventImpl;

  VerseModel get verse;
  @JsonKey(ignore: true)
  _$$UserSaveEventImplCopyWith<_$UserSaveEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
