part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class LoginEvent extends AuthEvent {
  final LoginParams params;

  LoginEvent({required this.params});
}

class RegisterEvent extends AuthEvent {
  final RegisterParams params;

  RegisterEvent({required this.params});
}
