import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:v2g/core/network/providers/auth_status_provider.dart';
import 'package:v2g/core/route/app_route.dart';
import 'package:v2g/main.dart';

class MainWidget extends ConsumerWidget {
  const MainWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authStatus = ref.watch(authStatusProvider);
    return authStatus.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, st) => Center(child: Text('Error: $e')),
      data: (isAuthenticated) {
        globalIsAuthenticated = isAuthenticated;
        return MaterialApp.router(
          routerConfig: ref.watch(goRouterProvider),
        );
      },
    );
  }
}
