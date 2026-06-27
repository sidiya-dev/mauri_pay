part of 'main_bloc.dart';

@immutable
sealed class MainEvent {}

class GetBalanceEvent extends MainEvent {}

class DepositRequested extends MainEvent {
  final double amount;
  DepositRequested(this.amount);
}
