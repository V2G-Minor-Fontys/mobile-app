import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:v2g/features/auth/presentation/providers/auth_state.dart';
import 'package:v2g/features/auth/presentation/providers/auth_viewmodel.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authViewModelProvider);
    final authViewModel = ref.read(authViewModelProvider.notifier);

    final isLoading = authState is Loading;

    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(labelText: 'Username'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 24),

            if (isLoading) const CircularProgressIndicator(),

            if (!isLoading)
              ElevatedButton(
                onPressed: () {
                  final username = _usernameController.text.trim();
                  final password = _passwordController.text.trim();
                  authViewModel.login(username: username, password: password);
                },
                child: const Text('Login'),
              ),

            const SizedBox(height: 12),

            if (authState is Error)
              Text(
                (authState).problem.detail,
                style: const TextStyle(color: Colors.red),
              ),

            if (authState is Authenticated)
              Text(
                'Welcome! ID: ${(authState).response.id}',
                style: const TextStyle(color: Colors.green),
              ),

            const SizedBox(height: 24),
            TextButton(
              onPressed: () => context.go('/register'),
              child: const Text("Don't have an account? Register here"),
            ),
          ],
        ),
      ),
    );
  }
}
