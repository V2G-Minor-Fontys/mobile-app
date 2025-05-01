import 'package:fpdart/fpdart.dart';
import 'package:v2g/core/exceptions/secure_storage_exception.dart';

abstract class ISecureStorageService {
  TaskEither<SecureStorageException, Unit> write(String key, String value);
  
  TaskEither<SecureStorageException, Option<String>> read(String key);

  TaskEither<SecureStorageException, Unit> delete(String key);

  TaskEither<SecureStorageException, bool> containsKey(String key);

  TaskEither<SecureStorageException, List<String>> getAllKeys();
}