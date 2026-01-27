part of 'make_transaction_bloc.dart';

@immutable
sealed class MakeTransactionEvent {}

final class MakeTransactionRequested extends MakeTransactionEvent {
  final MakeTransactionEntity transaction;

  MakeTransactionRequested(this.transaction);
}

final class MakeTransactionReset extends MakeTransactionEvent {}
