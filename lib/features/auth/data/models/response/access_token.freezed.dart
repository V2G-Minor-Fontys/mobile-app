// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'access_token.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AccessToken {
  String get value;
  DateTime get expiresAt;

  /// Create a copy of AccessToken
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AccessTokenCopyWith<AccessToken> get copyWith =>
      _$AccessTokenCopyWithImpl<AccessToken>(this as AccessToken, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AccessToken &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.expiresAt, expiresAt) ||
                other.expiresAt == expiresAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, value, expiresAt);

  @override
  String toString() {
    return 'AccessToken(value: $value, expiresAt: $expiresAt)';
  }
}

/// @nodoc
abstract mixin class $AccessTokenCopyWith<$Res> {
  factory $AccessTokenCopyWith(
          AccessToken value, $Res Function(AccessToken) _then) =
      _$AccessTokenCopyWithImpl;
  @useResult
  $Res call({String value, DateTime expiresAt});
}

/// @nodoc
class _$AccessTokenCopyWithImpl<$Res> implements $AccessTokenCopyWith<$Res> {
  _$AccessTokenCopyWithImpl(this._self, this._then);

  final AccessToken _self;
  final $Res Function(AccessToken) _then;

  /// Create a copy of AccessToken
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
    Object? expiresAt = null,
  }) {
    return _then(AccessToken(
      value: null == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
      expiresAt: null == expiresAt
          ? _self.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

// dart format on
