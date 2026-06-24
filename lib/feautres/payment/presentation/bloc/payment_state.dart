part of 'payment_bloc.dart';

@immutable
sealed class PaymentState {}

final class PaymentInitial extends PaymentState {}

/// Looking up a pasted code.
final class PaymentLoading extends PaymentState {}

/// Code resolved: show the read-only amount + merchant, then ask for the password.
final class PaymentPreviewLoaded extends PaymentState {
  final PaymentPreviewEntity preview;
  PaymentPreviewLoaded(this.preview);
}

/// Submitting the password / charging.
final class PaymentPaying extends PaymentState {
  final PaymentPreviewEntity preview;
  PaymentPaying(this.preview);
}

final class PaymentPaid extends PaymentState {
  final PaymentPreviewEntity preview;
  PaymentPaid(this.preview);
}

final class PaymentFailure extends PaymentState {
  final String message;
  final String? code;

  /// Preview is kept (when available) so the UI can stay on the right step.
  final PaymentPreviewEntity? preview;

  PaymentFailure(this.message, {this.code, this.preview});
}
