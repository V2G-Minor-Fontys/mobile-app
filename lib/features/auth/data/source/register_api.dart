import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';
import 'package:v2g/core/network/dio_provider.dart';
import 'package:v2g/features/auth/data/models/request/login_request.dart';
import 'package:v2g/features/auth/data/models/response/authentication_response.dart';
import 'package:v2g/features/auth/data/models/request/register_request.dart';

part 'register_api.g.dart';

final authApiProvider = Provider<AuthApi>((ref) {
  return AuthApi(ref.watch(dioProvider));
});

@RestApi()
abstract class AuthApi{
  factory AuthApi(Dio dio, {String baseUrl}) = _AuthApi;

  @POST('/auth/register')
  Future<AuthenticationResponse> register(@Body() RegisterRequest request);

  @POST('/auth/register')
  Future<AuthenticationResponse> login(@Body() LoginRequest request);

  @POST('/auth/token/refresh')
  Future<AuthenticationResponse> refreshToken();

  @POST('/auth/token/revoke')
  Future<HttpResponse> revokeToken();
}