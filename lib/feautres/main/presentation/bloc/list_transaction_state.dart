part of 'list_transaction_bloc.dart';

@immutable
abstract class ListTransactionState {}

class ListTransactionInitial extends ListTransactionState {}

class ListTransactionLoading extends ListTransactionState {}

class ListTransactionLoaded extends ListTransactionState {
  final List<TransactionEntity> transactions;

  ListTransactionLoaded(this.transactions);
}

class ListTransactionError extends ListTransactionState {
  final String message;

  ListTransactionError(this.message);
}
