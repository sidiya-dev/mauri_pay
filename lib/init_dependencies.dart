import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:mauri_pay/feautres/auth/data/datasources/auth_remote_datasource.dart';
import 'package:mauri_pay/feautres/auth/data/datasources/auth_remote_datasource_impl.dart';
import 'package:mauri_pay/feautres/auth/data/repositories/auth_repository_impl.dart';
import 'package:mauri_pay/feautres/auth/domain/repositories/auth_repository.dart';
import 'package:mauri_pay/feautres/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:mauri_pay/feautres/auth/domain/usecases/login_usecase.dart';
import 'package:mauri_pay/feautres/auth/domain/usecases/logout_usecase.dart';
import 'package:mauri_pay/feautres/auth/domain/usecases/register_usecase.dart';
import 'package:mauri_pay/feautres/auth/presentation/bloc/auth_bloc.dart';
import 'package:mauri_pay/feautres/main/data/datasources/main_remote_datasource.dart';
import 'package:mauri_pay/feautres/main/data/datasources/main_remote_datasource_impl.dart';
import 'package:mauri_pay/feautres/main/data/datasources/transaction_datasource.dart';
import 'package:mauri_pay/feautres/main/data/datasources/transaction_datasource_impl.dart';
import 'package:mauri_pay/feautres/main/data/repositories/main_repository_impl.dart';
import 'package:mauri_pay/feautres/main/data/repositories/transaction_repository_impl.dart';
import 'package:mauri_pay/feautres/main/domain/repositories/main_repository.dart';
import 'package:mauri_pay/feautres/main/domain/repositories/transaction_repository.dart';
import 'package:mauri_pay/feautres/main/domain/usecases/get_balanace.dart';
import 'package:mauri_pay/feautres/main/domain/usecases/list_transaction.dart';
import 'package:mauri_pay/feautres/main/domain/usecases/make_transaction.dart';
import 'package:mauri_pay/feautres/main/presentation/bloc/list_transaction_bloc.dart';
import 'package:mauri_pay/feautres/main/presentation/bloc/main_bloc.dart';
import 'package:mauri_pay/feautres/main/presentation/bloc/make_transaction_bloc.dart';
import 'package:mauri_pay/feautres/payment/data/datasources/payment_datasource.dart';
import 'package:mauri_pay/feautres/payment/data/datasources/payment_datasource_impl.dart';
import 'package:mauri_pay/feautres/payment/data/repositories/payment_repository_impl.dart';
import 'package:mauri_pay/feautres/payment/domain/repositories/payment_repository.dart';
import 'package:mauri_pay/feautres/payment/domain/usecases/get_payment_preview.dart';
import 'package:mauri_pay/feautres/payment/domain/usecases/pay_code.dart';
import 'package:mauri_pay/feautres/payment/presentation/bloc/payment_bloc.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  await initGlobal();
  await _initAuth();
  await _initMain();
  await _initMakeTransaction();
  await _initPayment();
}

Future<void> initGlobal() async {
  // In-memory cookie jar keeps the backend JSESSIONID so the session survives
  // across requests (login -> balance -> transfer ...).
  final cookieJar = CookieJar();
  final dio = Dio(
    BaseOptions(
      baseUrl: dotenv.get("API_URL"),
      headers: {'Content-Type': 'application/json'},
      responseType: ResponseType.json,
    ),
  )
    ..interceptors.add(CookieManager(cookieJar))
    // Session expired / not authenticated -> drive the auth state to Unauthenticated.
    // The router redirect (which listens to AuthBloc) then sends the user to login.
    ..interceptors.add(
      InterceptorsWrapper(
        onError: (e, handler) {
          final isAuthCall = e.requestOptions.path.contains('/auth/');
          if (e.response?.statusCode == 401 &&
              !isAuthCall &&
              sl.isRegistered<AuthBloc>()) {
            sl<AuthBloc>().add(SessionExpired());
          }
          handler.next(e);
        },
      ),
    );

  sl
    ..registerLazySingleton<CookieJar>(() => cookieJar)
    ..registerLazySingleton<Dio>(() => dio);
}

Future<void> _initAuth() async {
  sl
    ..registerLazySingleton<AuthRemoteDatasource>(
      () => AuthRemoteDatasourceImpl(dio: sl<Dio>()),
    )
    ..registerLazySingleton<AuthRepository>(
      () =>
          AuthRepositoryImpl(authRemoteDatasource: sl<AuthRemoteDatasource>()),
    )
    ..registerLazySingleton<RegisterUsecase>(
      () => RegisterUsecase(authRepository: sl<AuthRepository>()),
    )
    ..registerLazySingleton<LoginUsecase>(
      () => LoginUsecase(authRepository: sl<AuthRepository>()),
    )
    ..registerLazySingleton<LogoutUsecase>(
      () => LogoutUsecase(authRepository: sl<AuthRepository>()),
    )
    ..registerLazySingleton<GetCurrentUserUsecase>(
      () => GetCurrentUserUsecase(authRepository: sl<AuthRepository>()),
    )
    // Singleton so the router redirect, the 401 interceptor and the UI all
    // observe the same authentication state.
    ..registerLazySingleton<AuthBloc>(
      () => AuthBloc(
        loginUsecase: sl<LoginUsecase>(),
        registerUsecase: sl<RegisterUsecase>(),
        logoutUsecase: sl<LogoutUsecase>(),
        getCurrentUserUsecase: sl<GetCurrentUserUsecase>(),
      ),
    );
}

Future<void> _initMain() async {
  sl
    ..registerLazySingleton<MainRemoteDatasource>(
      () => MainRemoteDatasourceImpl(dio: sl<Dio>()),
    )
    ..registerLazySingleton<MainRepository>(
      () =>
          MainRepositoryImpl(mainRemoteDatasource: sl<MainRemoteDatasource>()),
    )
    ..registerLazySingleton<GetBalanaceUsecase>(
      () => GetBalanaceUsecase(mainRepository: sl<MainRepository>()),
    )
    ..registerFactoryParam<MainBloc, String, void>(
      (userId, _) =>
          MainBloc(getBalanace: sl<GetBalanaceUsecase>(), userId: userId),
    );
}

Future<void> _initMakeTransaction() async {
  sl
    // Data sources
    ..registerLazySingleton<TransactionDatasource>(
      () => TransactionDatasourceImpl(dio: sl<Dio>()),
    )
    // Repositories
    ..registerLazySingleton<TransactionRepository>(
      () => TransactionRepositoryImpl(
        transactionDatasource: sl<TransactionDatasource>(),
      ),
    )
    // Use cases
    ..registerLazySingleton<MakeTransaction>(
      () => MakeTransaction(
        makeTransactionRepository: sl<TransactionRepository>(),
      ),
    )
    ..registerLazySingleton<ListTransaction>(
      () => ListTransaction(repository: sl<TransactionRepository>()),
    )
    // Blocs
    ..registerFactoryParam<MakeTransactionBloc, String, void>(
      (userId, _) => MakeTransactionBloc(
        makeTransactionUseCase: sl<MakeTransaction>(),
        userId: userId,
      ),
    )
    ..registerFactoryParam<ListTransactionBloc, String, void>(
      (userId, _) => ListTransactionBloc(
        listTransaction: sl<ListTransaction>(),
        userId: userId,
      ),
    );
}

Future<void> _initPayment() async {
  sl
    ..registerLazySingleton<PaymentDatasource>(
      () => PaymentDatasourceImpl(dio: sl<Dio>()),
    )
    ..registerLazySingleton<PaymentRepository>(
      () => PaymentRepositoryImpl(paymentDatasource: sl<PaymentDatasource>()),
    )
    ..registerLazySingleton<GetPaymentPreview>(
      () => GetPaymentPreview(repository: sl<PaymentRepository>()),
    )
    ..registerLazySingleton<PayCode>(
      () => PayCode(repository: sl<PaymentRepository>()),
    )
    ..registerFactory<PaymentBloc>(
      () => PaymentBloc(
        getPreview: sl<GetPaymentPreview>(),
        payCode: sl<PayCode>(),
      ),
    );
}
