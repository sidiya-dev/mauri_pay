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

final sl = GetIt.instance;

Future<void> initDependencies() async {
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
    ..registerFactory<AuthBloc>(
      () => AuthBloc(
        loginUsecase: sl<LoginUsecase>(),
        registerUsecase: sl<RegisterUsecase>(),
      ),
    );
}
