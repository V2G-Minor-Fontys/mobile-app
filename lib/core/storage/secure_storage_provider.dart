import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final secureStorageProvider = Provider<FlutterSecureStorage>((ref) {
  const aOptions = AndroidOptions(
    encryptedSharedPreferences: true,
  );

  const iosOptions = IOSOptions(
    accessibility: KeychainAccessibility.first_unlock,
  );
  
  return const FlutterSecureStorage(aOptions: aOptions, iOptions: iosOptions);
});
