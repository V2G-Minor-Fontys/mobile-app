
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:v2g/core/network/dio_provider.dart';
import 'package:v2g/core/network/services/token_service.dart';
import 'package:v2g/features/auth/presentation/providers/auth_state.dart';
import 'package:v2g/features/auth/presentation/providers/auth_viewmodel.dart';

final authStatusProvider = FutureProvider<bool>((ref) async {
  final tokenService = ref.read(tokenServiceProvider(ref.read(dioProvider)));
  final result = await tokenService.refreshAccessToken().run();

  return result.isRight();
});

final isUserAuthenticatedProvider = Provider<bool>((ref) {
  final state = ref.watch(authViewModelProvider);
  return state is Authenticated;
});