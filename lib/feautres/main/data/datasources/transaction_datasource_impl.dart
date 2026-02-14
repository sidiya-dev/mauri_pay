import 'package:mauri_pay/core/error/exceptions.dart';
import 'package:mauri_pay/feautres/main/data/datasources/transaction_datasource.dart';
import 'package:mauri_pay/feautres/main/domain/entities/transaction_entity.dart';
import 'package:mauri_pay/feautres/main/domain/usecases/make_transaction.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TransactionDatasourceImpl implements TransactionDatasource {
  final SupabaseClient supabase;

  TransactionDatasourceImpl({required this.supabase});

  @override
  Future<bool> makeTransaction(MakeTransactionType params) async {
    print('Sending transaction:');
    print('SenderId: ${params.senderId}');
    print('ReceiverPhone: ${params.receiverPhone}');
    print('Amount: ${params.amount}');
    print('TransactionType: ${params.transactionType}');

    try {
      await supabase.rpc(
        'make_transfer',
        params: {
          'p_sender': params.senderId,
          'p_receiver_phone': params.receiverPhone,
          'p_amount': params.amount,
          'p_transaction_type': params.transactionType,
        },
      );

      return true;
    } catch (e) {
      print('Transaction exception: $e');
      throw ServerException('Transaction failed, please try again');
    }
  }

  @override
  Future<List<TransactionEntity>> getTransactions(String userId) async {
    print(userId);
    try {
      final data =
          await supabase.rpc(
                'get_user_transactions',
                params: {'p_user': userId},
              )
              as List<dynamic>;
      print(data.first);
      return data.map((e) => TransactionEntity.fromJson(e)).toList();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
