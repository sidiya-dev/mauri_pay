import 'package:dio/dio.dart';

class ServerException implements Exception {
  final String message;

  /// Stable backend error code (e.g. INVALID_CREDENTIALS) used to translate the message.
  final String? code;

  const ServerException(this.message, [this.code]);

  @override
  String toString() => message;
}

/// Converts a [DioException] into a [ServerException].
///
/// IMPORTANT: only a genuine connectivity failure (no HTTP response received at
/// all) is reported as `NETWORK` ("check your connection"). An HTTP error that
/// simply has no JSON body — e.g. an empty-bodied 401 from Spring Security on a
/// session check — must NOT be shown as a network error; it is classified by its
/// status code instead.
ServerException serverExceptionFromDio(DioException e) {
  final response = e.response;

  // No response object => real network/connection problem (DNS, timeout, TLS...).
  if (response == null) {
    return ServerException(e.message ?? 'Network error', 'NETWORK');
  }

  final data = response.data;
  if (data is Map) {
    final code = data['code']?.toString();
    final m = data['message'];
    final message = m is Map ? m.values.join(', ') : (m?.toString() ?? 'Error');
    return ServerException(message, code);
  }

  // We got an HTTP response, just not a JSON body (empty / HTML error page).
  // Classify by status so "not authenticated" is never mistaken for "no internet".
  switch (response.statusCode) {
    case 401:
      return const ServerException('Unauthorized', 'UNAUTHORIZED');
    case 403:
      return const ServerException('Forbidden', 'FORBIDDEN');
    default:
      final s = response.statusCode;
      return ServerException('Request failed${s != null ? ' ($s)' : ''}');
  }
}
