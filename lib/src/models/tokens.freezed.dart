// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tokens.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Tokens _$TokensFromJson(Map<String, dynamic> json) {
  return _Tokens.fromJson(json);
}

/// @nodoc
mixin _$Tokens {
  String? get accessToken => throw _privateConstructorUsedError;
  int? get accessTokenExp => throw _privateConstructorUsedError;
  int? get refreshTokenExp => throw _privateConstructorUsedError;
  String? get refreshToken => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TokensCopyWith<Tokens> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TokensCopyWith<$Res> {
  factory $TokensCopyWith(Tokens value, $Res Function(Tokens) then) =
      _$TokensCopyWithImpl<$Res, Tokens>;
  @useResult
  $Res call(
      {String? accessToken,
      int? accessTokenExp,
      int? refreshTokenExp,
      String? refreshToken});
}

/// @nodoc
class _$TokensCopyWithImpl<$Res, $Val extends Tokens>
    implements $TokensCopyWith<$Res> {
  _$TokensCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accessToken = freezed,
    Object? accessTokenExp = freezed,
    Object? refreshTokenExp = freezed,
    Object? refreshToken = freezed,
  }) {
    return _then(_value.copyWith(
      accessToken: freezed == accessToken
          ? _value.accessToken
          : accessToken // ignore: cast_nullable_to_non_nullable
              as String?,
      accessTokenExp: freezed == accessTokenExp
          ? _value.accessTokenExp
          : accessTokenExp // ignore: cast_nullable_to_non_nullable
              as int?,
      refreshTokenExp: freezed == refreshTokenExp
          ? _value.refreshTokenExp
          : refreshTokenExp // ignore: cast_nullable_to_non_nullable
              as int?,
      refreshToken: freezed == refreshToken
          ? _value.refreshToken
          : refreshToken // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TokensCopyWith<$Res> implements $TokensCopyWith<$Res> {
  factory _$$_TokensCopyWith(_$_Tokens value, $Res Function(_$_Tokens) then) =
      __$$_TokensCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? accessToken,
      int? accessTokenExp,
      int? refreshTokenExp,
      String? refreshToken});
}

/// @nodoc
class __$$_TokensCopyWithImpl<$Res>
    extends _$TokensCopyWithImpl<$Res, _$_Tokens>
    implements _$$_TokensCopyWith<$Res> {
  __$$_TokensCopyWithImpl(_$_Tokens _value, $Res Function(_$_Tokens) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accessToken = freezed,
    Object? accessTokenExp = freezed,
    Object? refreshTokenExp = freezed,
    Object? refreshToken = freezed,
  }) {
    return _then(_$_Tokens(
      accessToken: freezed == accessToken
          ? _value.accessToken
          : accessToken // ignore: cast_nullable_to_non_nullable
              as String?,
      accessTokenExp: freezed == accessTokenExp
          ? _value.accessTokenExp
          : accessTokenExp // ignore: cast_nullable_to_non_nullable
              as int?,
      refreshTokenExp: freezed == refreshTokenExp
          ? _value.refreshTokenExp
          : refreshTokenExp // ignore: cast_nullable_to_non_nullable
              as int?,
      refreshToken: freezed == refreshToken
          ? _value.refreshToken
          : refreshToken // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Tokens implements _Tokens {
  const _$_Tokens(
      {this.accessToken,
      this.accessTokenExp,
      this.refreshTokenExp,
      this.refreshToken});

  factory _$_Tokens.fromJson(Map<String, dynamic> json) =>
      _$$_TokensFromJson(json);

  @override
  final String? accessToken;
  @override
  final int? accessTokenExp;
  @override
  final int? refreshTokenExp;
  @override
  final String? refreshToken;

  @override
  String toString() {
    return 'Tokens(accessToken: $accessToken, accessTokenExp: $accessTokenExp, refreshTokenExp: $refreshTokenExp, refreshToken: $refreshToken)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Tokens &&
            (identical(other.accessToken, accessToken) ||
                other.accessToken == accessToken) &&
            (identical(other.accessTokenExp, accessTokenExp) ||
                other.accessTokenExp == accessTokenExp) &&
            (identical(other.refreshTokenExp, refreshTokenExp) ||
                other.refreshTokenExp == refreshTokenExp) &&
            (identical(other.refreshToken, refreshToken) ||
                other.refreshToken == refreshToken));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, accessToken, accessTokenExp, refreshTokenExp, refreshToken);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TokensCopyWith<_$_Tokens> get copyWith =>
      __$$_TokensCopyWithImpl<_$_Tokens>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TokensToJson(
      this,
    );
  }
}

abstract class _Tokens implements Tokens {
  const factory _Tokens(
      {final String? accessToken,
      final int? accessTokenExp,
      final int? refreshTokenExp,
      final String? refreshToken}) = _$_Tokens;

  factory _Tokens.fromJson(Map<String, dynamic> json) = _$_Tokens.fromJson;

  @override
  String? get accessToken;
  @override
  int? get accessTokenExp;
  @override
  int? get refreshTokenExp;
  @override
  String? get refreshToken;
  @override
  @JsonKey(ignore: true)
  _$$_TokensCopyWith<_$_Tokens> get copyWith =>
      throw _privateConstructorUsedError;
}
