import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:v2g/features/auth/data/models/response/access_token.dart';

part 'authentication_response.freezed.dart';
part 'authentication_response.g.dart';

@freezed
@JsonSerializable()
class AuthenticationResponse with _$AuthenticationResponse {
  const AuthenticationResponse({
    required this.accessToken,
    required this.id,
  });

  @override
  @JsonKey(name: 'accessToken')
  final AccessToken accessToken;
  @override
  @JsonKey(name: 'id')
  final String id;
  
  factory AuthenticationResponse.fromJson(Map<String, dynamic> json) => _$AuthenticationResponseFromJson(json);
  Map<String, Object?> toJson() => _$AuthenticationResponseToJson(this);
}