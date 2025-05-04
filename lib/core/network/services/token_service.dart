import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:v2g/core/exceptions/token_service_exception.dart';
import 'package:v2g/core/network/services/itoken_service.dart';
import 'package:v2g/core/storage/isecure_storage_service.dart';
import 'package:v2g/core/storage/secure_storage_keys.dart';
import 'package:v2g/core/storage/secure_storage_service.dart';

final tokenServiceProvider = ProviderFamily<ITokenService, Dio>((ref, dio) {
  return TokenService(
    dio,
    ref.watch(secureStorageServiceProvider),
  );
});

final class TokenService implements ITokenService {
  final Dio _dio;
  final ISecureStorageService _secureStorageService;

  TokenService(this._dio, this._secureStorageService);

  @override
  TaskEither<TokenServiceException, String> getAccessToken() {
    return _secureStorageService.read(accessTokenKey).mapLeft<TokenServiceException>(
      (e) => TokenMissingException('Failed to read access token: ${e.toString()}'),
    ).flatMap(
      (tokenOption) => tokenOption.match(
        () => refreshAccessToken().mapLeft<TokenServiceException>((e) => TokenMissingException('Failed to refresh access token: ${e.toString()}')),
        TaskEither.right,           
      ),
    );
  }

  @override
  TaskEither<TokenServiceException, String> refreshAccessToken() {
    return TaskEither.tryCatch(() async {
      final response = await _dio.post('/api/auth/token/refresh');

      if (response.statusCode == HttpStatus.unauthorized) {
        throw const TokenMissingException('Invalid refresh token: token is missing or expired');
      }

      if (response.data is! Map<String, dynamic>) {
        throw const TokenRefreshFailedException('Failed to parse token response');
      }

      final token = response.data['accessToken']?['value'] as String?;
      if (token == null) {
        throw const TokenMissingException('Access token not found in refresh response');
      }

      final writeResult = await _secureStorageService.write(accessTokenKey, token).run();
      if (writeResult.isLeft()) {
        throw TokenSaveFailedException('Failed to write access token: ${writeResult.getLeft().toString()}');
      }

      return token;
    }, (error, _) {
      return error is TokenServiceException
          ? error
          : TokenRefreshFailedException(error.toString());
    });
  }

  @override
  TaskEither<TokenServiceException, Response<dynamic>> retryWithFreshToken(RequestOptions failedRequest) {
    return getAccessToken().flatMap(
      (accessToken) {
        return TaskEither.tryCatch(() async {
          failedRequest.headers[HttpHeaders.authorizationHeader] = 'Bearer $accessToken';
          return await _dio.fetch(failedRequest);
        }, (error, _) {
          return TokenRefreshFailedException(
            error is DioException ? error.message ?? 'Unknown Dio error' : error.toString(),
          );
        });
      },
    );
  }

  @override
  TaskEither<TokenServiceException, Unit> saveAccessToken(String token) {
    return TaskEither.tryCatch(() async {
      final result = await _secureStorageService.write(accessTokenKey, token).run();
      if (result.isLeft()) {
        throw TokenSaveFailedException('Failed to write access token: ${result.getLeft().toString()}');
      }
      return unit;
    }, (error, _) {
      return TokenSaveFailedException(error.toString());
    });
  }
}


