sealed class TokenServiceException implements Exception {
  final String message;
  const TokenServiceException(this.message);
}

final class TokenMissingException extends TokenServiceException {
  const TokenMissingException(super.message);
}

final class TokenSaveFailedException extends TokenServiceException {
  const TokenSaveFailedException(super.message);
}

final class TokenRefreshFailedException extends TokenServiceException {
  const TokenRefreshFailedException(super.message);
}