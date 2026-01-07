import 'package:fpdart/fpdart.dart';
import 'package:mauri_pay/core/error/failure.dart';
import 'package:mauri_pay/feautres/auth/domain/entities/auth_entity.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, AuthEntity>> register(AuthEntity entity);
}