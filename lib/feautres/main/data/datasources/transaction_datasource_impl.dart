import 'package:dio/dio.dart';
import 'package:mauri_pay/core/error/exceptions.dart';
import 'package:mauri_pay/feautres/main/data/datasources/transaction_datasource.dart';
import 'package:mauri_pay/feautres/main/domain/entities/transaction_entity.dart';
import 'package:mauri_pay/feautres/main/domain/usecases/make_transaction.dart';

class TransactionDatasourceImpl implements TransactionDatasource {
  final Dio dio;

  TransactionDatasourceImpl({required this.dio});

  @override
  Future<bool> makeTransaction(MakeTransactionType params) async {
    try {
      await dio.post(
        '/api/v1/transfers',
        data: {
          'receiverPhone': params.receiverPhone,
          'amount': params.amount,
          'transactionType': params.transactionType,
        },
      );
      return true;
    } on DioException catch (e) {
      throw _toException(e);
    } catch (e) {
      throw ServerException('Transaction failed, please try again');
    }
  }

  @override
  Future<List<TransactionEntity>> getTransactions(String userId) async {
    try {
      // Session identifies the user; the backend returns this user's history.
      final response = await dio.get('/api/v1/transactions');
      final data = response.data as List<dynamic>;
      return data
          .map((e) => TransactionEntity.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw _toException(e);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  ServerException _toException(DioException e) => serverExceptionFromDio(e);
}
