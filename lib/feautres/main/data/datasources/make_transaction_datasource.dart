import 'package:mauri_pay/feautres/main/data/models/make_transaction_model.dart';
import 'package:mauri_pay/feautres/main/domain/usecases/make_transaction.dart';

abstract interface class MakeTransactionDatasource {
  Future<MakeTransactionModel> makeTransaction(MakeTransactionType params);
}