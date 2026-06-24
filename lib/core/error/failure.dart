class Failure {
  final String message;

  /// Stable backend error code (e.g. INVALID_CREDENTIALS) used to translate the message.
  final String? code;

  Failure({required this.message, this.code});
}
