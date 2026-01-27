import 'package:dio/dio.dart';
import 'package:mauri_pay/core/error/exceptions.dart';
import 'package:mauri_pay/feautres/main/data/datasources/make_transaction_datasource.dart';
import 'package:mauri_pay/feautres/main/data/models/make_transaction_model.dart';
import 'package:mauri_pay/feautres/main/domain/usecases/make_transaction.dart';

class MakeTransactionDatasourceImpl implements MakeTransactionDatasource {
  final Dio dio;

  MakeTransactionDatasourceImpl({required this.dio});

  @override
  Future<MakeTransactionModel> makeTransaction(
    MakeTransactionType params,
  ) async {
    try {
      final response = await dio.post(
        '/transactions',
        data: {
          'sender_id': params.senderId,
          'receiver_phone': params,
          'amount': params.amount,
          'transaction_type_id': params.transactionTypeId,
        },
      );

      return MakeTransactionModel.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response != null) {
        final statusCode = e.response!.statusCode;
        final message = e.response!.data['error'];

        if (statusCode == 400 || statusCode == 404) {
          throw ServerException(message);
        }
      }

      throw ServerException('Transaction failed, please try again');
    }
  }
}
