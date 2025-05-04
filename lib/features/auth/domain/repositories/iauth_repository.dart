import 'package:fpdart/fpdart.dart';
import 'package:v2g/core/network/models/problem_details.dart';
import 'package:v2g/features/auth/data/models/response/authentication_response.dart';

abstract class IAuthRepository {
  TaskEither<ProblemDetails, AuthenticationResponse> register(String username, String password);

  TaskEither<ProblemDetails, AuthenticationResponse> login(String username, String password);

  TaskEither<ProblemDetails, AuthenticationResponse> refreshToken();

  TaskEither<ProblemDetails, Unit> revokeToken();
}