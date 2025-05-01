import 'package:freezed_annotation/freezed_annotation.dart';

part 'problem_details.freezed.dart';
part 'problem_details.g.dart';

@freezed
sealed class ProblemDetails with _$ProblemDetails {
  const factory ProblemDetails({
    required String type,
    required String title,
    required int status,
    required String detail,
    String? instance,
  }) = _ProblemDetails;

  factory ProblemDetails.fromJson(Map<String, dynamic> json) =>
      _$ProblemDetailsFromJson(json);
}
