import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:v2g/core/network/models/problem_details.dart';
import 'package:v2g/features/auth/data/models/response/authentication_response.dart';

part 'auth_state.freezed.dart';

@freezed
sealed class AuthState with _$AuthState {
  const factory AuthState.initial() = Initial;
  const factory AuthState.loading() = Loading;
  const factory AuthState.authenticated(AuthenticationResponse response) = Authenticated;
  const factory AuthState.error(ProblemDetails problem) = Error;
}