import 'package:bloc/bloc.dart';
import 'package:mauri_pay/feautres/main/domain/entities/transaction_entity.dart';
import 'package:mauri_pay/feautres/main/domain/usecases/list_transaction.dart';
import 'package:meta/meta.dart';

part 'list_transaction_event.dart';
part 'list_transaction_state.dart';

class ListTransactionBloc
    extends Bloc<ListTransactionEvent, ListTransactionState> {
  final ListTransaction listTransaction;
  final String userId;

  ListTransactionBloc({required this.listTransaction, required this.userId})
      : super(ListTransactionInitial()) {
    on<LoadTransactions>(_onLoadTransactions);
  }

  Future<void> _onLoadTransactions(
    LoadTransactions event,
    Emitter<ListTransactionState> emit,
  ) async {
    emit(ListTransactionLoading());

    try {
      final result = await listTransaction(userId);
      result.fold(
        (failure) => emit(ListTransactionError(failure.message)),
        (transactions) => emit(ListTransactionLoaded(transactions)),
      );
    } catch (e) {
      emit(ListTransactionError('Unexpected error: $e'));
    }
  }
}
