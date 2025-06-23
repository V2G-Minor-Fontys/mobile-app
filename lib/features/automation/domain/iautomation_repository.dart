import 'package:fpdart/fpdart.dart';
import 'package:v2g/core/network/models/problem_details.dart';
import 'package:v2g/features/auth/data/models/response/authentication_response.dart';

abstract class IAutomationRepository {
  TaskEither<ProblemDetails, AuthenticationResponse> getAutomations(
      String userID);

  TaskEither<ProblemDetails, AuthenticationResponse> create(String userID);

  TaskEither<ProblemDetails, AuthenticationResponse> delete(String id);

  TaskEither<ProblemDetails, Unit> edit();
  TaskEither<ProblemDetails, Unit> reorder(
      String id, int oldIndex, int newIndex);
}
