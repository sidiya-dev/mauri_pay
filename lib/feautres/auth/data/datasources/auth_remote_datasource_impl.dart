import 'package:dio/dio.dart';
import 'package:mauri_pay/core/error/exceptions.dart';
import 'package:mauri_pay/feautres/auth/data/datasources/auth_remote_datasource.dart';
import 'package:mauri_pay/feautres/auth/data/models/user_model.dart';
import 'package:mauri_pay/feautres/auth/domain/usecases/login_usecase.dart';
import 'package:mauri_pay/feautres/auth/domain/usecases/register_usecase.dart';

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  final Dio dio;

  AuthRemoteDatasourceImpl({required this.dio});
  @override
  Future<UserModel> login(LoginParams params) async {
    try {
      final result = await dio.post("/auth/login", data: params.toJson());
      return UserModel.fromJson(result.data["user"]);
    } on DioException catch (e) {
      throw ServerException(e.response?.data["error"]);
    }
  }

  @override
  Future<UserModel> register(RegisterParams params) async {
    try {
      print(params.toJson());
      final result = await dio.post("/auth/register", data: params.toJson());
      return UserModel.fromJson(result.data["user"]);
    } on DioException catch (e) {
      throw ServerException(e.response?.data["error"]);
    }
  }
}
