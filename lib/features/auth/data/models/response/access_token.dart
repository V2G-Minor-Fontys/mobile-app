import 'package:freezed_annotation/freezed_annotation.dart';

part 'access_token.freezed.dart';
part 'access_token.g.dart';

@freezed
@JsonSerializable()
class AccessToken with _$AccessToken {
  const AccessToken({
    required this.value,
    required this.expiresAt,
  });

  @override
  @JsonKey(name: 'value')
  final String value;
  @override
  @JsonKey(name: 'expiresAt')
  final DateTime expiresAt;

  factory AccessToken.fromJson(Map<String, dynamic> json) => _$AccessTokenFromJson(json);
   Map<String, Object?> toJson() => _$AccessTokenToJson(this);
}
