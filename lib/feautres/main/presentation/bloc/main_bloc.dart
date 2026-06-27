import 'package:bloc/bloc.dart';
import 'package:mauri_pay/feautres/main/domain/usecases/deposit_usecase.dart';
import 'package:mauri_pay/feautres/main/domain/usecases/get_balanace.dart';
import 'package:meta/meta.dart';

part 'main_event.dart';
part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  final GetBalanaceUsecase _getBalanace;
  final DepositUsecase _deposit;
  final String _userId;

  MainBloc({
    required GetBalanaceUsecase getBalanace,
    required DepositUsecase deposit,
    required String userId,
  }) : _getBalanace = getBalanace,
       _deposit = deposit,
       _userId = userId,
       super(MainInitial()) {
    on<GetBalanceEvent>((event, emit) async {
      emit(MainLoading());

      final result = await _getBalanace(_userId);

      result.fold(
        (failure) => emit(MainError(message: failure.message)),
        (balance) => emit(MainSuccess(balance: balance)),
      );
    });

    on<DepositRequested>((event, emit) async {
      emit(MainLoading());

      final result = await _deposit(event.amount);

      result.fold(
        (failure) =>
            emit(DepositFailure(message: failure.message, code: failure.code)),
        (balance) => emit(DepositSuccess(balance: balance)),
      );
    });
  }
}
