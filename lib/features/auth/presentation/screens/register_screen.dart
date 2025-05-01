import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:v2g/features/auth/presentation/providers/auth_state.dart';
import 'package:v2g/features/auth/presentation/providers/auth_viewmodel.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authViewModelProvider);
    final authViewModel = ref.read(authViewModelProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
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
            const SizedBox(height: 12),
            TextField(
              controller: _confirmPasswordController,
              decoration: const InputDecoration(labelText: 'Confirm Password'),
              obscureText: true,
            ),
            const SizedBox(height: 24),
            Builder(
              builder: (context) {
                final onPressed = () {
                  final username = _usernameController.text.trim();
                  final password = _passwordController.text.trim();
                  final confirmPassword =
                      _confirmPasswordController.text.trim();

                  if (password != confirmPassword) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Passwords do not match')),
                    );
                    return;
                  }

                  authViewModel.register(
                    username: username,
                    password: password,
                  );
                };

                return switch (authState) {
                  Loading() => const CircularProgressIndicator(),
                  Error(:final problem) => Column(
                      children: [
                        ElevatedButton(
                          onPressed: onPressed,
                          child: const Text('Register'),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Error: ${problem.detail}',
                          style: const TextStyle(color: Colors.red),
                        ),
                      ],
                    ),
                  Authenticated(:final response) => ElevatedButton(
                      onPressed: null,
                      child: Text('Welcome! ID: ${response.id}'),
                    ),
                  Initial() => ElevatedButton(
                      onPressed: onPressed,
                      child: const Text('Register'),
                    ),
                };
              },
            ),
            const SizedBox(height: 24),
            Builder(
              builder: (context) {
                return switch (authState) {
                  Error(:final problem) => Text('Error: ${problem.detail}'),
                  Authenticated(:final response) =>
                    Text('Welcome! ID: ${response.id}'),
                  _ => const SizedBox.shrink(),
                };
              },
            ),
            TextButton(
              onPressed: () => context.go('/login'),
              child: const Text('Already have an account? Login here'),
            ),
          ],
        ),
      ),
    );
  }
}
