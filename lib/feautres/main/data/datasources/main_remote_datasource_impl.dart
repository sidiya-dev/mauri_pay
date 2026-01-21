import 'package:dio/dio.dart';
import 'package:mauri_pay/core/error/exceptions.dart';
import 'package:mauri_pay/feautres/main/data/datasources/main_remote_datasource.dart';

class MainRemoteDatasourceImpl implements MainRemoteDatasource {
  final Dio dio;

  MainRemoteDatasourceImpl({required this.dio});

  @override
  Future<int> getBalance(int user_id) {
    try {
      return dio
          .get('/users/$user_id/balance/')
          .then((response) => response.data['balance'] as int);
    } catch (e) {
      throw ServerException('Failed to load balance');
    }
  }
}
