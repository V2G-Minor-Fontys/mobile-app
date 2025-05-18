import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:v2g/common/widgets/neumorphic_button.dart';
import 'package:v2g/common/widgets/outlined_text_field.dart';
import 'package:v2g/common/widgets/styled_text_button.dart';
import 'package:v2g/core/utils/theming.dart';
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
    final errorMessage = authState is Error ? authState.problem.detail : null;

    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Column(
              children: [
                OutlinedTextField(
                  controller: _usernameController,
                  hintText: 'Username',
                  prefixIcon: Icons.person,
                ),
                const SizedBox(height: 12),
                OutlinedTextField(
                  controller: _passwordController,
                  hintText: 'Password',
                  prefixIcon: Icons.lock,
                  obscureText: true,
                ),
                const SizedBox(height: 24),
                NeumorphicButton(
                  height: 48,
                  width: 200,
                  isLoading: isLoading,
                  child: const Text('Login'),
                  onPressed: () {
                    final username = _usernameController.text.trim();
                    final password = _passwordController.text.trim();
                    context.go('/home');
                  },
                ),
                const SizedBox(height: 12),
                if (errorMessage != null) ...[
                  const SizedBox(height: 12),
                  Text(
                    errorMessage,
                    style: TextStyle(
                      color: context.colorScheme.error,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  )],
                const SizedBox(height: 24),
                StyledTextButton(
                  onPressed: () => context.go('/register'),
                  label: "Don't have an account? Register here",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
