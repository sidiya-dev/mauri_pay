import 'package:bloc/bloc.dart';
import 'package:mauri_pay/feautres/main/domain/entities/make_transaction_entity.dart';
import 'package:mauri_pay/feautres/main/domain/usecases/make_transaction.dart';
import 'package:meta/meta.dart';

part 'make_transaction_event.dart';
part 'make_transaction_state.dart';

class MakeTransactionBloc
    extends Bloc<MakeTransactionEvent, MakeTransactionState> {
  final MakeTransaction makeTransactionUseCase;
  final int userId;

  MakeTransactionBloc({required this.makeTransactionUseCase, required this.userId})
    : super(MakeTransactionInitial()) {
    on<MakeTransactionRequested>(_onMakeTransactionRequested);

    on<MakeTransactionReset>((event, emit) {
      emit(MakeTransactionInitial());
    });
  }

  Future<void> _onMakeTransactionRequested(
    MakeTransactionRequested event,
    Emitter<MakeTransactionState> emit,
  ) async {
    emit(MakeTransactionLoading());

    try {
      final result = await makeTransactionUseCase(
        MakeTransactionType(
          amount: event.transaction.amount,
          senderId: event.transaction.senderId,
          receiverPhone: event.transaction.receiverPhone,
          transactionTypeId: event.transaction.transactionTypeId,
        ),
      );
      result.fold(
        (l) => emit(MakeTransactionFailure(l.message)),
        (r) => emit(MakeTransactionSuccess()),
      );
    } catch (e) {
      emit(MakeTransactionFailure(e.toString()));
    }
  }
}
