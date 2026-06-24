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

/// Dispatched on app start to resolve whether a session is already active.
class AuthCheckRequested extends AuthEvent {}

/// Dispatched when the backend reports the session is no longer valid (401).
class SessionExpired extends AuthEvent {}

class LogoutEvent extends AuthEvent {}
