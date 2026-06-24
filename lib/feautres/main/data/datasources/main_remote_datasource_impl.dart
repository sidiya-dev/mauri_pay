import 'package:dio/dio.dart';
import 'package:mauri_pay/core/error/exceptions.dart';
import 'package:mauri_pay/feautres/main/data/datasources/main_remote_datasource.dart';

class MainRemoteDatasourceImpl implements MainRemoteDatasource {
  final Dio dio;

  MainRemoteDatasourceImpl({required this.dio});

  @override
  Future<double> getBalance(String userId) async {
    try {
      // The current user is identified by the session cookie, so userId is unused.
      final response = await dio.get('/api/v1/me');
      final balance = (response.data['balance'] as num).toDouble();
      return balance;
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'Failed to load balance');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
