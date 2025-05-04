import 'package:cookie_jar/cookie_jar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final cookieJarProvider = Provider<PersistCookieJar>((ref) {
  throw UnimplementedError('Must override cookieJarProvider in main()');
});
