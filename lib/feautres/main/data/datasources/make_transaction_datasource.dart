import 'package:mauri_pay/feautres/main/domain/usecases/make_transaction.dart';

abstract interface class MakeTransactionDatasource {
  Future<bool> makeTransaction(MakeTransactionType params);
}