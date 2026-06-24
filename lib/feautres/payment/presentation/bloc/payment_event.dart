part of 'payment_bloc.dart';

@immutable
sealed class PaymentEvent {}

/// Look up a pasted code and load its (read-only) amount + merchant.
class LoadPreview extends PaymentEvent {
  final String code;
  LoadPreview(this.code);
}

/// Pay the previewed code with the user's password.
class PayRequested extends PaymentEvent {
  final String code;
  final String password;
  PayRequested({required this.code, required this.password});
}

class ResetPayment extends PaymentEvent {}
