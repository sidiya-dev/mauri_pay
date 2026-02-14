import 'package:fpdart/fpdart.dart';
import 'package:mauri_pay/core/error/failure.dart';
import 'package:mauri_pay/feautres/main/domain/usecases/make_transaction.dart';

abstract interface class MakeTransactionRepository {
  Future<Either<Failure,bool>> makeTransaction(MakeTransactionType params);
}