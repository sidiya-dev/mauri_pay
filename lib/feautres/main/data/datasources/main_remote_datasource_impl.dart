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
      throw serverExceptionFromDio(e);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<double> deposit(double amount) async {
    try {
      // Credits the session user's own account; returns the updated balance.
      final response =
          await dio.post('/api/v1/dev/topup', data: {'amount': amount});
      final data = response.data;
      if (data is Map && data['balance'] != null) {
        return (data['balance'] as num).toDouble();
      }
      // Fallback: re-read the balance if the endpoint didn't echo it.
      return getBalance('');
    } on DioException catch (e) {
      throw serverExceptionFromDio(e);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
