import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:v2g/core/network/models/problem_details.dart';
import 'package:v2g/features/auth/data/models/response/authentication_response.dart';
import 'package:v2g/features/auth/data/repository/auth_repository.dart';
import 'package:v2g/features/auth/domain/repositories/iauth_repository.dart';

final loginUseCaseProvider = Provider<LoginUseCase>((ref) {
  return LoginUseCase(ref.watch(authRepositoryProvider));
});

final class LoginUseCase {
  final IAuthRepository _authRepository;

  LoginUseCase(this._authRepository);

  TaskEither<ProblemDetails, AuthenticationResponse> call({
    required String username,
    required String password,
  }) {
    return _authRepository.login(username, password);
  }
}