import 'package:fpdart/fpdart.dart';
import 'package:mauri_pay/core/error/failure.dart';
import 'package:mauri_pay/feautres/auth/domain/entities/user_entity.dart';
import 'package:mauri_pay/feautres/auth/domain/repositories/auth_repository.dart';

/// Resolves the current user from the active session (GET /me).
/// A Left means there is no valid session (e.g. expired / never logged in).
class GetCurrentUserUsecase {
  final AuthRepository authRepository;

  GetCurrentUserUsecase({required this.authRepository});

  Future<Either<Failure, UserEntity>> call() => authRepository.currentUser();
}
