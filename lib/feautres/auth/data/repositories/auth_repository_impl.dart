import 'package:fpdart/src/either.dart';
import 'package:mauri_pay/core/error/exceptions.dart';
import 'package:mauri_pay/core/error/failure.dart';
import 'package:mauri_pay/feautres/auth/data/datasources/auth_remote_datasource.dart';
import 'package:mauri_pay/feautres/auth/domain/entities/user_entity.dart';
import 'package:mauri_pay/feautres/auth/domain/repositories/auth_repository.dart';
import 'package:mauri_pay/feautres/auth/domain/usecases/login_usecase.dart';
import 'package:mauri_pay/feautres/auth/domain/usecases/register_usecase.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource authRemoteDatasource;

  AuthRepositoryImpl({required this.authRemoteDatasource});

  @override
  Future<Either<Failure, UserEntity>> register({
    required RegisterParams params,
  }) async {
    try {
      final user = await authRemoteDatasource.register(params);
      return Right(user);
    } on ServerException catch (e) {
      return Left(Failure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> login({
    required LoginParams params,
  }) async {
    try {
      final user = await authRemoteDatasource.login(params);
      return Right(user);
    } on ServerException catch (e) {
      return Left(Failure(message: e.message));
    }
  }
}
