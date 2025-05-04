import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_request.freezed.dart';
part 'login_request.g.dart';

@freezed
@JsonSerializable()
class LoginRequest with _$LoginRequest {
  const LoginRequest({
    required this.username,
    required this.password,
  });

  @override
  @JsonKey(name: 'username')
  final String username;
  @override
  @JsonKey(name: 'password')
  final String password;

  factory LoginRequest.fromJson(Map<String, dynamic> json) => _$LoginRequestFromJson(json);
  Map<String, Object?> toJson() => _$LoginRequestToJson(this);
}