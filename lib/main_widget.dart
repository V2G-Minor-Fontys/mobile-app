import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:v2g/core/network/providers/initial_auth_status_provider.dart';
import 'package:v2g/core/route/app_route.dart';
import 'package:v2g/core/utils/theming.dart';

class MainWidget extends StatelessWidget {
  final bool isAuthenticated;

  const MainWidget({super.key, required this.isAuthenticated});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: [
        initialAuthStatusProvider.overrideWithValue(isAuthenticated),
      ],
      child: const _MainWidgetRouter(),
    );
  }
}

class _MainWidgetRouter extends ConsumerWidget {
  const _MainWidgetRouter();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      routerConfig: ref.watch(goRouterProvider),
    );
  }
}
