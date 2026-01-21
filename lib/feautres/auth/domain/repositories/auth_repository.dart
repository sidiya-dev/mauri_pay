import 'package:fpdart/fpdart.dart';
import 'package:mauri_pay/core/error/failure.dart';
import 'package:mauri_pay/feautres/auth/domain/entities/user_entity.dart';
import 'package:mauri_pay/feautres/auth/domain/usecases/login_usecase.dart';
import 'package:mauri_pay/feautres/auth/domain/usecases/register_usecase.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, UserEntity>> register({
    required RegisterParams params
  });
  Future<Either<Failure, UserEntity>> login({
    required LoginParams params
  });
}
