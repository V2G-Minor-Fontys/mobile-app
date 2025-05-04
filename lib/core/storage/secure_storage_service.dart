import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fpdart/fpdart.dart';
import 'package:v2g/core/exceptions/secure_storage_exception.dart';
import 'package:v2g/core/storage/isecure_storage_service.dart';
import 'package:v2g/core/storage/secure_storage_provider.dart';

final secureStorageServiceProvider = Provider<ISecureStorageService>((ref) {
  final storage = ref.watch(secureStorageProvider);
  return SecureStorageService(storage);
});

class SecureStorageService implements ISecureStorageService {
  final FlutterSecureStorage storage;

  SecureStorageService(this.storage);
  @override
  TaskEither<SecureStorageException, Unit> write(String key, String value) {
    return TaskEither.tryCatch(
      () async => await storage.write(key: key, value: value).then((_) => unit),
      (e, _) => WriteException('Write error: ${e.toString()}'),
    );
  }

  @override
  TaskEither<SecureStorageException, Option<String>> read(String key) {
    return TaskEither.tryCatch(
      () async {
        final value = await storage.read(key: key);
        return optionOf(value);
      },
      (e, _) => ReadException('Read error: ${e.toString()}'),
    );
  }

  @override
  TaskEither<SecureStorageException, Unit> delete(String key) {
    return TaskEither.tryCatch(
      () async => await storage.delete(key: key).then((_) => unit),
      (e, _) => DeleteException('Delete error: ${e.toString()}'),
    );
  }

  @override
  TaskEither<SecureStorageException, bool> containsKey(String key) {
    return TaskEither.tryCatch(
      () => storage.containsKey(key: key),
      (e, _) => ReadException('Contains key error: ${e.toString()}'),
    );
  }

  @override
  TaskEither<SecureStorageException, List<String>> getAllKeys() {
    return TaskEither.tryCatch(
      () async => (await storage.readAll()).keys.toList(),
      (e, _) => ReadException('Get all keys error: ${e.toString()}'),
    );
  }
}
