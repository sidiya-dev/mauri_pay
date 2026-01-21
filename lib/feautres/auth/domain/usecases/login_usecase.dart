import 'package:fpdart/src/either.dart';
import 'package:mauri_pay/core/error/failure.dart';
import 'package:mauri_pay/core/usecase/usecase.dart';
import 'package:mauri_pay/feautres/auth/domain/entities/user_entity.dart';
import 'package:mauri_pay/feautres/auth/domain/repositories/auth_repository.dart';

class LoginUsecase implements Usecase<UserEntity, LoginParams> {
  final AuthRepository authRepository;

  LoginUsecase({required this.authRepository});

  @override
  Future<Either<Failure, UserEntity>> call(params) async {
    return await authRepository.login(params: params);
  }
}

class LoginParams {
  final String phone;
  final String password;

  LoginParams({required this.phone, required this.password});

  Map<String, dynamic> toJson() {
    return {"phone_number": phone, "password": password};
  }
}
