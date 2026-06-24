import 'package:dio/dio.dart';
import 'package:mauri_pay/core/error/exceptions.dart';
import 'package:mauri_pay/feautres/payment/data/datasources/payment_datasource.dart';
import 'package:mauri_pay/feautres/payment/domain/entities/payment_preview_entity.dart';

class PaymentDatasourceImpl implements PaymentDatasource {
  final Dio dio;

  PaymentDatasourceImpl({required this.dio});

  @override
  Future<PaymentPreviewEntity> getPreview(String code) async {
    try {
      final response = await dio.get('/api/v1/payments/$code');
      return PaymentPreviewEntity.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw _toException(e);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> pay(String code, String password) async {
    try {
      await dio.post('/api/v1/payments/$code/pay', data: {'password': password});
    } on DioException catch (e) {
      throw _toException(e);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  ServerException _toException(DioException e) {
    final data = e.response?.data;
    if (data is Map) {
      final code = data['code']?.toString();
      final m = data['message'];
      final message = m is Map ? m.values.join(', ') : (m?.toString() ?? 'Error');
      return ServerException(message, code);
    }
    return ServerException(e.message ?? 'Network error', 'NETWORK');
  }
}
