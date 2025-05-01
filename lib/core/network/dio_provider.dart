
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:v2g/core/network/interceptors/auth_interceptor.dart';
import 'package:v2g/core/network/interceptors/problem_details_interceptor.dart';
import 'package:v2g/core/network/services/token_service.dart';
import 'package:v2g/core/route/route_path.dart';
import 'package:v2g/main.dart';

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio();

  dio.options = BaseOptions(
    baseUrl: baseUrl,
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
  );

  final tokenService = ref.read(tokenServiceProvider(dio));

  dio.interceptors.addAll(
      [ ProblemDetailsInterceptor(),CookieManager(globalCookieJar), AuthInterceptor(tokenService), LogInterceptor(requestBody: true, responseBody: true)]);
  return dio;
});