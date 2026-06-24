import 'package:mauri_pay/l10n/app_localizations.dart';

/// Maps a backend [code] to a localized message. Falls back to the raw [fallback]
/// message (or a generic translated message) when the code is unknown/null.
String localizedError(AppLocalizations t, String? code, [String fallback = '']) {
  switch (code) {
    case 'INVALID_CREDENTIALS':
      return t.error_invalid_credentials;
    case 'ACCOUNT_LOCKED':
      return t.error_account_locked;
    case 'PHONE_ALREADY_EXISTS':
      return t.error_phone_already_exists;
    case 'RECIPIENT_NOT_FOUND':
      return t.error_recipient_not_found;
    case 'INSUFFICIENT_BALANCE':
      return t.error_insufficient_balance;
    case 'SELF_TRANSFER':
      return t.error_self_transfer;
    case 'PAYMENT_NOT_FOUND':
      return t.error_payment_not_found;
    case 'PAYMENT_ALREADY_PAID':
      return t.error_payment_already_paid;
    case 'PAYMENT_EXPIRED':
      return t.error_payment_expired;
    case 'PAYMENT_NOT_PAYABLE':
      return t.error_payment_not_payable;
    case 'INVALID_PASSWORD':
      return t.error_invalid_password;
    case 'NETWORK':
      return t.error_network;
    default:
      return fallback.isNotEmpty ? fallback : t.error_unexpected;
  }
}
