part of 'make_transaction_bloc.dart';

@immutable
sealed class MakeTransactionState {}

final class MakeTransactionInitial extends MakeTransactionState {}

final class MakeTransactionLoading extends MakeTransactionState {}

final class MakeTransactionSuccess extends MakeTransactionState {}

final class MakeTransactionFailure extends MakeTransactionState {
  final String error;

  MakeTransactionFailure(this.error);
}
