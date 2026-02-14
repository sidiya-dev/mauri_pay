import 'package:fpdart/fpdart.dart';
import 'package:mauri_pay/core/error/failure.dart';
import 'package:mauri_pay/feautres/main/domain/entities/transaction_entity.dart';
import 'package:mauri_pay/feautres/main/domain/usecases/make_transaction.dart';

abstract interface class TransactionRepository {
  Future<Either<Failure,bool>> makeTransaction(MakeTransactionType params);
  Future<Either<Failure, List<TransactionEntity>>> getTransactions(String userId);
}