import 'package:bloc/bloc.dart';
import 'package:mauri_pay/feautres/main/domain/usecases/get_balanace.dart';
import 'package:meta/meta.dart';

part 'main_event.dart';
part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  final GetBalanaceUsecase _getBalanace;
  final String _userId;

  MainBloc({required GetBalanaceUsecase getBalanace, required String userId})
    : _getBalanace = getBalanace,
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
  }
}
