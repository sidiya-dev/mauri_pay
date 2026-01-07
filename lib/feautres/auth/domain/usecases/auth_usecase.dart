import 'package:fpdart/fpdart.dart';
import 'package:mauri_pay/core/error/failure.dart';
import 'package:mauri_pay/feautres/auth/domain/entities/auth_entity.dart';
import 'package:mauri_pay/feautres/auth/domain/repositories/auth_repository.dart';

class AuthUsecase {
  final AuthRepository authRepository;

  AuthUsecase({required this.authRepository});
  Future<Either<Failure, AuthEntity>> call(AuthEntity entity) {
    return authRepository.register(entity);
  }
}