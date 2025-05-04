import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:v2g/core/network/models/problem_details.dart';
import 'package:v2g/features/auth/data/models/response/authentication_response.dart';
import 'package:v2g/features/auth/data/repository/auth_repository.dart';
import 'package:v2g/features/auth/domain/repositories/iauth_repository.dart';

final registerUseCaseProvider = Provider<RegisterUseCase>((ref) {
  return RegisterUseCase(ref.watch(authRepositoryProvider));
});

final class RegisterUseCase {
  final IAuthRepository _authRepository;

  RegisterUseCase(this._authRepository);

  TaskEither<ProblemDetails, AuthenticationResponse> call({
    required String username,
    required String password,
  }) {
    return _authRepository.register(username, password);
  }
}