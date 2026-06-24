class ServerException implements Exception {
  final String message;

  /// Stable backend error code (e.g. INVALID_CREDENTIALS) used to translate the message.
  final String? code;

  const ServerException(this.message, [this.code]);

  @override
  String toString() => message;
}
