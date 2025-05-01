import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:v2g/core/network/models/problem_details.dart';
import 'package:v2g/features/auth/data/models/request/login_request.dart';
import 'package:v2g/features/auth/data/models/response/authentication_response.dart';
import 'package:v2g/features/auth/data/models/request/register_request.dart';
import 'package:v2g/features/auth/domain/repositories/iauth_repository.dart';
import 'package:v2g/features/auth/data/datasources/auth_api.dart';

final authRepositoryProvider = Provider<IAuthRepository>((ref) {
  return AuthRepository(ref.watch(authApiProvider));
});

final class AuthRepository implements IAuthRepository {
  final AuthApi _authApi;

  AuthRepository(this._authApi);

  @override
  TaskEither<ProblemDetails, AuthenticationResponse> register(
      String username, String password) {
    return TaskEither.tryCatch(
      () async {
        final response = await _authApi.register(
          RegisterRequest(username: username, password: password),
        );
        return response;
      },
      (error, stackTrace) {
        if (error is DioException && error.error is ProblemDetails) {
          return error.error as ProblemDetails;
        } else {
          return const ProblemDetails(
            title: 'Unknown Error',
            detail: 'An unknown error occurred.',
            status: 500,
            type: 'UnknownError',
          );
        }
      },
    );
  }

  @override
  TaskEither<ProblemDetails, AuthenticationResponse> login(
      String username, String password) {
    return TaskEither.tryCatch(
      () async {
        final response = await _authApi.login(
          LoginRequest(username: username, password: password),
        );
        return response;
      },
      (error, stackTrace) {
        if (error is DioException) {
          if (error.error is ProblemDetails) {
            return error.error as ProblemDetails;
          }
          return ProblemDetails(
            title: 'Unknown Error',
            detail: error.message ?? 'An unknown error occurred.',
            status: 500,
            type: error.type.toString(),
          );
        }
        return const ProblemDetails(
            title: 'Unknown Error',
            detail: 'An unknown error occurred.',
            status: 500,
            type: 'UnknownError');
      },
    );
  }

  @override
  TaskEither<ProblemDetails, AuthenticationResponse> refreshToken() {
    return TaskEither.tryCatch(
      () async {
        final response = await _authApi.refreshToken();
        return response;
      },
      (error, stackTrace) {
        if (error is DioException && error.error is ProblemDetails) {
          return error.error as ProblemDetails;
        } else {
          return const ProblemDetails(
            title: 'Unknown Error',
            detail: 'An unknown error occurred.',
            status: 500,
            type: 'UnknownError',
          );
        }
      },
    );
  }

  @override
  TaskEither<ProblemDetails, Unit> revokeToken() {
    return TaskEither.tryCatch(
      () async {
        await _authApi.revokeToken();
        return unit;
      },
      (error, stackTrace) {
        if (error is DioException && error.error is ProblemDetails) {
          return error.error as ProblemDetails;
        } else {
          return const ProblemDetails(
            title: 'Unknown Error',
            detail: 'An unknown error occurred.',
            status: 500,
            type: 'UnknownError',
          );
        }
      },
    );
  }
}
