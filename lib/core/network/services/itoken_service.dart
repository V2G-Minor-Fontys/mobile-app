import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:v2g/core/exceptions/token_service_exception.dart';

abstract class ITokenService {
  TaskEither<TokenServiceException, String> getAccessToken();

  TaskEither<TokenServiceException, Unit> saveAccessToken(String token);
  
  TaskEither<TokenServiceException, String> refreshAccessToken();

  TaskEither<TokenServiceException, Response<dynamic>> retryWithFreshToken(RequestOptions failedRequest);
}

