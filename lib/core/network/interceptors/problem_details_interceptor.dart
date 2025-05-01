import 'package:dio/dio.dart';
import 'package:v2g/core/network/models/problem_details.dart';

class ProblemDetailsInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
      try {
        final problem = ProblemDetails.fromJson(err.response?.data);
        final newErr = DioException(
          requestOptions: err.requestOptions,
          response: err.response,
          type: err.type,
          error: problem,
          message: err.message,
          stackTrace: err.stackTrace,
        );

        return handler.next(newErr);
      } catch (_) {
        final newErr = DioException(
          requestOptions: err.requestOptions,
          response: err.response,
          type: err.type,
          error: ProblemDetails(
            type: err.type.toString(),
            title: "Internal Error",
            status: 500,
            detail: err.message ?? 'An unknown error occurred',
          ),
          message: err.message,
          stackTrace: err.stackTrace,
        );
        return handler.next(newErr);
      }
  }
}
