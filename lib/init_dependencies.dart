import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:mauri_pay/feautres/auth/data/datasources/auth_remote_datasource.dart';
import 'package:mauri_pay/feautres/auth/data/datasources/auth_remote_datasource_impl.dart';
import 'package:mauri_pay/feautres/auth/data/repositories/auth_repository_impl.dart';
import 'package:mauri_pay/feautres/auth/domain/repositories/auth_repository.dart';
import 'package:mauri_pay/feautres/auth/domain/usecases/login_usecase.dart';
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
import 'package:supabase_flutter/supabase_flutter.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  await initGlobal();
  await _initAuth();
  await _initMain();
  await _initMakeTransaction();
}

Future<void> initGlobal() async {
  final supabase = Supabase.instance.client;
  sl
    ..registerLazySingleton<Dio>(
      () => Dio(
        BaseOptions(
          baseUrl: dotenv.get("API_URL"),
          headers: {'Content-Type': 'application/json'},
          responseType: ResponseType.json,
        ),
      ),
    )
    ..registerLazySingleton<SupabaseClient>(() => supabase);
}

Future<void> _initAuth() async {
  sl
    ..registerLazySingleton<AuthRemoteDatasource>(
      () => AuthRemoteDatasourceImpl(supabase: sl<SupabaseClient>()),
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
    ..registerFactory<AuthBloc>(
      () => AuthBloc(
        loginUsecase: sl<LoginUsecase>(),
        registerUsecase: sl<RegisterUsecase>(),
      ),
    );
}

Future<void> _initMain() async {
  sl
    ..registerLazySingleton<MainRemoteDatasource>(
      () => MainRemoteDatasourceImpl(supabase: sl<SupabaseClient>()),
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
      () => TransactionDatasourceImpl(supabase: sl<SupabaseClient>()),
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
