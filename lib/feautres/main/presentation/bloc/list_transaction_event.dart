part of 'list_transaction_bloc.dart';

@immutable
abstract class ListTransactionEvent {}

class LoadTransactions extends ListTransactionEvent {}
