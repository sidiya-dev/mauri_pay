import 'package:bloc/bloc.dart';
import 'package:mauri_pay/feautres/auth/domain/entities/user_entity.dart';
import 'package:mauri_pay/feautres/auth/domain/usecases/login_usecase.dart';
import 'package:mauri_pay/feautres/auth/domain/usecases/register_usecase.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUsecase _loginUsecase;
  final RegisterUsecase _registerUsecase;

  AuthBloc({
    required LoginUsecase loginUsecase,
    required RegisterUsecase registerUsecase,
  }) : _loginUsecase = loginUsecase,
       _registerUsecase = registerUsecase,
       super(AuthInitial()) {
    on<LoginEvent>((event, emit) async {
      emit(Loading());
      final result = await _loginUsecase.call(event.params);
      result.fold(
        (failure) => emit(Error(message: failure.message)),
        (user) => emit(Success(user: user)),
      );
    });

    on<RegisterEvent>((event, emit) async {
      emit(Loading());
      final result = await _registerUsecase.call(event.params);
      result.fold(
        (failure) => emit(Error(message: failure.message)),
        (user) => emit(Success(user: user)),
      );
    });
  }
}
