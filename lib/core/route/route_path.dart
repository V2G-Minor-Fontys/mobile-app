import 'package:flutter_dotenv/flutter_dotenv.dart';

final baseUrl = dotenv.env['BASE_URL']!;
const String loginPath = '/api/auth/login';
const String registerPath = '/api/auth/register';
const String refreshTokenPath = '/api/auth/token/refresh';
const String revokePath = '/api/auth/token/revoke';
const String getUserPath = '/api/users';

const String getAutomationsPath = '/api/charging-preferences';
const String createAutomationPath = '/api/charging-preferences';
const String editAutomationPath = '/api/charging-preferences';
const String deleteAutomationPath = '/api/charging-preferences';
const String reorderAutomationPath = '/api/charging-preferences/reorder';
