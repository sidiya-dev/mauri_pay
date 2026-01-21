part of 'main_bloc.dart';

@immutable
sealed class MainState {}

final class MainInitial extends MainState {}
final class MainSuccess extends MainState {
  final int balance;

  MainSuccess({required this.balance});
}
final class MainError extends MainState {
  final String message;

  MainError({required this.message});
}
final class MainLoading extends MainState {}