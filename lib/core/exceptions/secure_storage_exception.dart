sealed class SecureStorageException implements Exception {
  final String message;
  const SecureStorageException(this.message);
}

class WriteException extends SecureStorageException {
  const WriteException(super.message);
}

class ReadException extends SecureStorageException {
  const ReadException(super.message);
}

class DeleteException extends SecureStorageException {
  const DeleteException(super.message);
}
