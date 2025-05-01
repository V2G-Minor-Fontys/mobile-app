// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'authentication_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AuthenticationResponse {
  AccessToken get accessToken;
  String get id;

  /// Create a copy of AuthenticationResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AuthenticationResponseCopyWith<AuthenticationResponse> get copyWith =>
      _$AuthenticationResponseCopyWithImpl<AuthenticationResponse>(
          this as AuthenticationResponse, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AuthenticationResponse &&
            (identical(other.accessToken, accessToken) ||
                other.accessToken == accessToken) &&
            (identical(other.id, id) || other.id == id));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, accessToken, id);

  @override
  String toString() {
    return 'AuthenticationResponse(accessToken: $accessToken, id: $id)';
  }
}

/// @nodoc
abstract mixin class $AuthenticationResponseCopyWith<$Res> {
  factory $AuthenticationResponseCopyWith(AuthenticationResponse value,
          $Res Function(AuthenticationResponse) _then) =
      _$AuthenticationResponseCopyWithImpl;
  @useResult
  $Res call({AccessToken accessToken, String id});
}

/// @nodoc
class _$AuthenticationResponseCopyWithImpl<$Res>
    implements $AuthenticationResponseCopyWith<$Res> {
  _$AuthenticationResponseCopyWithImpl(this._self, this._then);

  final AuthenticationResponse _self;
  final $Res Function(AuthenticationResponse) _then;

  /// Create a copy of AuthenticationResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accessToken = null,
    Object? id = null,
  }) {
    return _then(AuthenticationResponse(
      accessToken: null == accessToken
          ? _self.accessToken
          : accessToken // ignore: cast_nullable_to_non_nullable
              as AccessToken,
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
