import 'package:mauri_pay/feautres/main/domain/entities/transaction_entity.dart';
import 'package:mauri_pay/feautres/main/domain/usecases/make_transaction.dart';

abstract interface class TransactionDatasource {
  Future<bool> makeTransaction(MakeTransactionType params);
  Future<List<TransactionEntity>> getTransactions(String userId);
}