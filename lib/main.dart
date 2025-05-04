import 'package:cookie_jar/cookie_jar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:v2g/core/network/providers/auth_status_provider.dart';
import 'package:v2g/core/network/providers/cookie_jar_provider.dart';
import 'package:v2g/main_widget.dart';

Future<void> main() async {
  await dotenv.load();

  WidgetsFlutterBinding.ensureInitialized();
  final dir = await getApplicationDocumentsDirectory();

  final cookieJar = PersistCookieJar(
    storage: FileStorage('${dir.path}/.cookies'),
  );
  
  final container = ProviderContainer(overrides: [
    cookieJarProvider.overrideWithValue(cookieJar),
  ]);
 final isAuthenticated = await container.read(authStatusProvider.future);


  runApp(UncontrolledProviderScope(
    container: container,
    child: MainWidget(isAuthenticated: isAuthenticated)));
}
