import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Central runtime configuration, driven by `.env`.
///
/// Flip a single variable to wire/rewire between local development and the
/// deployed production backend:
///
///   PRODUCTION=true       -> uses API_URL_PROD
///   PRODUCTION=false       -> uses API_URL_DEV
///
/// See `.env.example` for the expected keys.
class AppConfig {
  AppConfig._();

  /// True when the app targets the deployed production MauriPay backend.
  static bool get isProduction =>
      dotenv.get('PRODUCTION', fallback: 'false').trim().toLowerCase() == 'true';

  /// Backend base URL, selected by [isProduction]. Falls back to the legacy
  /// single `API_URL` key if the split keys aren't present.
  static String get apiUrl {
    final key = isProduction ? 'API_URL_PROD' : 'API_URL_DEV';
    return dotenv.get(key, fallback: dotenv.get('API_URL', fallback: ''));
  }
}
