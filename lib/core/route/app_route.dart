import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:v2g/core/route/route_path.dart';
import 'package:v2g/features/auth/presentation/screens/login_screen.dart';
import 'package:v2g/features/auth/presentation/screens/register_screen.dart';
import 'package:v2g/features/home/presentation/screens/home_screen.dart';
import 'package:v2g/main.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  final initialLocation = globalIsAuthenticated
      ? '/home'
      : '/login'; 

  return GoRouter(
    initialLocation: initialLocation,
    routes: [
      GoRoute(
        path: '/login',
        name: loginPath,
        builder: (context, state) => const LoginScreen(),
      ),
            GoRoute(
        path: '/home',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/register',
        name: registerPath,
        builder: (context, state) => const RegisterScreen(),
      )],
      redirect: (context, state) => globalIsAuthenticated ? null : '/login',);
});