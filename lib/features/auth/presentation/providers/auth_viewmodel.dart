import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:v2g/features/auth/domain/usecases/login_usecase.dart';
import 'package:v2g/features/auth/domain/usecases/register_usecase.dart';
import 'package:v2g/features/auth/presentation/providers/auth_state.dart';

final authViewModelProvider = StateNotifierProvider<AuthViewModel, AuthState>(
  (ref) => AuthViewModel(ref.read(loginUseCaseProvider), ref.read(registerUseCaseProvider)),
);

final class AuthViewModel extends StateNotifier<AuthState> {
  final LoginUseCase _loginUseCase;
  final RegisterUseCase _registerUseCase;

  AuthViewModel(this._loginUseCase, this._registerUseCase) : super(const AuthState.initial());

  Future<void> login({
    required String username,
    required String password,
  }) async {
    state = const AuthState.loading();

    final result =
        await _loginUseCase(username: username, password: password).run();

    result.match(
      (problem) => state = AuthState.error(problem),
      (authResponse) => state = AuthState.authenticated(authResponse),
    );
  }

    Future<void> register({
    required String username,
    required String password,
  }) async {
    state = const AuthState.loading();

    final result =
        await _registerUseCase(username: username, password: password).run();

    result.match(
      (problem) => state = AuthState.error(problem),
      (authResponse) => state = AuthState.authenticated(authResponse),
    );
  }

  void logout() {
    state = const AuthState.initial();
  }
}
