import 'package:mauri_pay/feautres/auth/data/models/user_model.dart';
import 'package:mauri_pay/feautres/auth/domain/usecases/login_usecase.dart';
import 'package:mauri_pay/feautres/auth/domain/usecases/register_usecase.dart';

abstract interface class AuthRemoteDatasource {
  Future<UserModel> register(RegisterParams params);
  Future<UserModel> login(LoginParams params);
}