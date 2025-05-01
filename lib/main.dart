import 'package:cookie_jar/cookie_jar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:v2g/main_widget.dart';

late final PersistCookieJar globalCookieJar;
bool globalIsAuthenticated = false;


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dir = await getApplicationDocumentsDirectory();

  globalCookieJar = PersistCookieJar(
    storage: FileStorage('${dir.path}/.cookies'),
  );

  runApp(const ProviderScope(child: MainWidget()));
}
