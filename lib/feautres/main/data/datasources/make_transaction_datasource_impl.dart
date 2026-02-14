import 'package:dio/dio.dart';
import 'package:mauri_pay/core/error/exceptions.dart';
import 'package:mauri_pay/feautres/main/data/datasources/make_transaction_datasource.dart';
import 'package:mauri_pay/feautres/main/domain/usecases/make_transaction.dart';

class MakeTransactionDatasourceImpl implements MakeTransactionDatasource {
  final Dio dio;

  MakeTransactionDatasourceImpl({required this.dio});

  @override
  Future<bool> makeTransaction(MakeTransactionType params) async {
    print('Sending transaction:');
    print('SenderId: ${params.senderId}');
    print('ReceiverPhone: ${params.receiverPhone}');
    print('Amount: ${params.amount}');
    print('TransactionTypeId: ${params.transactionTypeId}');

    try {
      await dio.post(
        '/transactions',
        data: {
          'sender_id': params.senderId,
          'receiver_phone': params.receiverPhone,
          'amount': params.amount,
          'transaction_type_id': params.transactionTypeId,
        },
      );
      return true;
    } on DioException catch (e) {
      print('DioException caught: ${e.response?.data}');
      print('Dio status code: ${e.response?.statusCode}');

      final serverMessage = e.response?.data?['error'] ?? e.message;

      throw ServerException(serverMessage);
    } catch (e) {
      print('Unknown exception: $e');
      throw ServerException('Transaction failed, please try again');
    }
  }
}
