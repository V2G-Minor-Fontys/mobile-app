import 'dart:io';
import 'package:dio/dio.dart';
import 'package:v2g/core/network/services/itoken_service.dart';

final class AuthInterceptor extends Interceptor {
  final ITokenService _tokenService;

  AuthInterceptor(this._tokenService);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (_isAuthEndpoint(options.path)) {
      return handler.next(options);
    }

    final tokenResult = await _tokenService.getAccessToken().run();
    tokenResult.match(
      (failure) => handler.reject(
        DioException(
          requestOptions: options,
          error: failure.toString(),
          type: DioExceptionType.badResponse,
        ),
      ),
      (token) {
        options.headers[HttpHeaders.authorizationHeader] = 'Bearer $token';
        handler.next(options);
      },
    );
  }

  @override
  void onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) async {
    if (_isAuthEndpoint(response.realUri.path) &&
        response.statusCode != HttpStatus.unauthorized) {
      final saveResult = await _tokenService
          .saveAccessToken(response.data['accessToken']['value'])
          .run();

      if (saveResult.isLeft()) {
        return handler.reject(
          DioException(
            requestOptions: response.requestOptions,
            error: saveResult.getLeft().toString(),
            type: DioExceptionType.badResponse,
          ),
        );
      }
    }

    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode != HttpStatus.unauthorized) {
      return handler.next(err);
    }

    final retryResult =
        await _tokenService.retryWithFreshToken(err.requestOptions).run();

    retryResult.match(
      (failure) => handler.reject(
        DioException(
          requestOptions: err.requestOptions,
          error: failure.toString(),
          type: DioExceptionType.badResponse,
        ),
      ),
      (response) => handler.resolve(response),
    );
  }

  bool _isAuthEndpoint(String path) => path.contains('/auth');
}
