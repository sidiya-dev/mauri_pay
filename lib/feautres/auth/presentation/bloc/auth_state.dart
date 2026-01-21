part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class Success extends AuthState {
  final UserEntity user;

  Success({required this.user});
}

final class Error extends AuthState {
  final String message;

  Error({required this.message});
}

final class Loading extends AuthState {}
