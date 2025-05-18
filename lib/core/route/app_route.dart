import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:v2g/core/network/providers/auth_status_provider.dart';
import 'package:v2g/core/network/providers/initial_auth_status_provider.dart';
import 'package:v2g/core/route/route_path.dart';
import 'package:v2g/features/auth/presentation/screens/login_screen.dart';
import 'package:v2g/features/auth/presentation/screens/register_screen.dart';
import 'package:v2g/features/automation/presentation/screens/automation_screen.dart';
import 'package:v2g/features/home/presentation/screens/home_screen.dart';
import 'package:v2g/features/settings/presentation/screens/settings_screen.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  final initialAuthStatus = ref.watch(initialAuthStatusProvider);
  return GoRouter(
    initialLocation: initialAuthStatus ? '/home' : '/login',
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: '/settings',
        builder: (context, state) => const SettingsScreen(),
      ),
      GoRoute(
        path: '/automation',
        builder: (context, state) => const AutomationListScreen(),
      )
    ],

  );
}, dependencies: [initialAuthStatusProvider]);
