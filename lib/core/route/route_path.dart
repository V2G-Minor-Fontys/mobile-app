import 'package:flutter_dotenv/flutter_dotenv.dart';

final baseUrl = dotenv.env['BASE_URL']!;
const String loginPath = '/api/auth/login';
const String registerPath = '/api/auth/register';
const String refreshTokenPath = '/api/auth/token/refresh';
const String revokePath = '/api/auth/token/revoke';
const String getUserPath = '/api/users';
