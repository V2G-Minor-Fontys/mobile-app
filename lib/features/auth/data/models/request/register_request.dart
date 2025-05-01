
import 'package:freezed_annotation/freezed_annotation.dart';

part 'register_request.freezed.dart';
part 'register_request.g.dart';

@freezed
@JsonSerializable()
class RegisterRequest with _$RegisterRequest {
  const RegisterRequest({
    required this.username,
    required this.password,
  });

  @override
  @JsonKey(name: 'username')
  final String username;
  @override
  @JsonKey(name: 'password')
  final String password;

  factory RegisterRequest.fromJson(Map<String, dynamic> json) => _$RegisterRequestFromJson(json);
    Map<String, Object?> toJson() => _$RegisterRequestToJson(this);
}