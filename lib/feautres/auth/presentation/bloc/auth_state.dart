part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

/// Initial/unknown state while the session is being checked on startup.
final class AuthInitial extends AuthState {}

/// Confirmed: no valid session (logged out, expired, or never authenticated).
final class Unauthenticated extends AuthState {}

final class Success extends AuthState {
  final UserEntity user;

  Success({required this.user});
}

final class Error extends AuthState {
  final String message;
  final String? code;

  Error({required this.message, this.code});
}

final class Loading extends AuthState {}
