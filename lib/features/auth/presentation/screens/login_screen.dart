import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
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
  final formKey = GlobalKey<ShadFormState>();

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
        body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: ShadCard(
          padding: const EdgeInsets.all(24),
          child: ShadForm(
            key: formKey,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: Text(
                      "Login",
                      style: ShadTheme.of(context).textTheme.h1,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ShadInputFormField(
                    controller: _usernameController,
                    label: const Text("Username"),
                    placeholder: const Text("Enter your username"),
                    validator: (v) {
                      if (v.length < 3) {
                        return "Username must be at least 3 characters long";
                      }

                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  ShadInputFormField(
                    controller: _passwordController,
                    label: const Text("Password"),
                    placeholder: const Text("Enter your password"),
                    obscureText: true,
                    validator: (v) {
                      if (v.length < 6) {
                        return "Password must be at least 6 characters long";
                      }

                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  ShadButton(
                    width: double.infinity,
                    child: isLoading
                        ? CircularProgressIndicator(
                            strokeWidth: 2,
                            color: ShadTheme.of(context)
                                .colorScheme
                                .primaryForeground,
                          )
                        : const Text("Login"),
                    onPressed: () {
                      if (formKey.currentState!.saveAndValidate()) {
                      
                        context.go("/home");
                      } else {
                        ShadToaster.of(context).show(ShadToast.destructive(
                          title: const Text("Failed to logged in"),
                          description: const Text(
                              "You have nottttt successfully logged in."),
                          action: ShadButton.outline(
                            child: const Text("Continue"),
                            onPressed: () => ShadToaster.of(context).hide(),
                          ),
                        ));
                      }
                    },
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don't have an account?",
                            style: ShadTheme.of(context).textTheme.muted),
                        const SizedBox(width: 8),
                        Text("Register!",
                            style: ShadTheme.of(context)
                                .textTheme
                                .muted
                                .copyWith(decoration: TextDecoration.underline))
                      ],
                    ),
                  )
                ]),
          ),
        ),
      ),
    ));
  }
}
