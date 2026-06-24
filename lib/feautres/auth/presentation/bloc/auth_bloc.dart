import 'package:bloc/bloc.dart';
import 'package:mauri_pay/feautres/auth/domain/entities/user_entity.dart';
import 'package:mauri_pay/feautres/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:mauri_pay/feautres/auth/domain/usecases/login_usecase.dart';
import 'package:mauri_pay/feautres/auth/domain/usecases/logout_usecase.dart';
import 'package:mauri_pay/feautres/auth/domain/usecases/register_usecase.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUsecase _loginUsecase;
  final RegisterUsecase _registerUsecase;
  final LogoutUsecase _logoutUsecase;
  final GetCurrentUserUsecase _getCurrentUserUsecase;

  AuthBloc({
    required LoginUsecase loginUsecase,
    required RegisterUsecase registerUsecase,
    required LogoutUsecase logoutUsecase,
    required GetCurrentUserUsecase getCurrentUserUsecase,
  }) : _loginUsecase = loginUsecase,
       _registerUsecase = registerUsecase,
       _logoutUsecase = logoutUsecase,
       _getCurrentUserUsecase = getCurrentUserUsecase,
       super(AuthInitial()) {
    on<AuthCheckRequested>((event, emit) async {
      final result = await _getCurrentUserUsecase.call();
      result.fold(
        (_) => emit(Unauthenticated()),
        (user) => emit(Success(user: user)),
      );
    });

    on<SessionExpired>((event, emit) {
      if (state is! Success) return;
      emit(Unauthenticated());
    });

    on<LoginEvent>((event, emit) async {
      emit(Loading());
      final result = await _loginUsecase.call(event.params);
      result.fold(
        (failure) => emit(Error(message: failure.message, code: failure.code)),
        (user) => emit(Success(user: user)),
      );
    });

    on<RegisterEvent>((event, emit) async {
      emit(Loading());
      final result = await _registerUsecase.call(event.params);
      result.fold(
        (failure) => emit(Error(message: failure.message, code: failure.code)),
        (user) => emit(Success(user: user)),
      );
    });

    on<LogoutEvent>((event, emit) async {
      await _logoutUsecase.call();
      emit(Unauthenticated());
    });
  }
}
