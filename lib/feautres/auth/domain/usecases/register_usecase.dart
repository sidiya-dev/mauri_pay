import 'package:fpdart/src/either.dart';
import 'package:mauri_pay/core/error/failure.dart';
import 'package:mauri_pay/core/usecase/usecase.dart';
import 'package:mauri_pay/feautres/auth/domain/entities/user_entity.dart';
import 'package:mauri_pay/feautres/auth/domain/repositories/auth_repository.dart';

class RegisterUsecase implements Usecase<UserEntity, RegisterParams> {
  final AuthRepository authRepository;

  RegisterUsecase({required this.authRepository});

  @override
  Future<Either<Failure, UserEntity>> call(params) async {
    return await authRepository.register(params: params);
  }
}

class RegisterParams {
  final String firstName;
  final String lastName;
  final String phone;
  final String password;

  RegisterParams({
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.password,
  });

  String get fullName => "$firstName $lastName".trim();

  Map<String, dynamic> toJson() {
    return {
      "fullName": fullName,
      "phone": phone,
      "password": password,
    };
  }
}
