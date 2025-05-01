
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:v2g/core/network/dio_provider.dart';
import 'package:v2g/core/network/services/token_service.dart';

final authStatusProvider = FutureProvider<bool>((ref) async {
  final tokenService = ref.read(tokenServiceProvider(ref.read(dioProvider)));
  final result = await tokenService.getAccessToken().run();

  return result.isRight();
});