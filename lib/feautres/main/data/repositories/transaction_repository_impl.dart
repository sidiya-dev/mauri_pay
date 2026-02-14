import 'package:fpdart/src/either.dart';
import 'package:mauri_pay/core/error/failure.dart';
import 'package:mauri_pay/feautres/main/data/datasources/transaction_datasource.dart';
import 'package:mauri_pay/feautres/main/domain/entities/transaction_entity.dart';
import 'package:mauri_pay/feautres/main/domain/repositories/transaction_repository.dart';
import 'package:mauri_pay/feautres/main/domain/usecases/make_transaction.dart';

class TransactionRepositoryImpl implements TransactionRepository {
  final TransactionDatasource transactionDatasource;

  TransactionRepositoryImpl({required this.transactionDatasource});
  @override
  Future<Either<Failure, bool>> makeTransaction(MakeTransactionType params) async{
    try {
      final result = await transactionDatasource.makeTransaction(params);
      return Right(result);
    } catch (e) {
      return Left(Failure(message: 'Failed make transaction'));
    }
  }

  @override
  Future<Either<Failure, List<TransactionEntity>>> getTransactions(String userId) async {
    try {
      final transactions = await transactionDatasource.getTransactions(userId);
      return Right(transactions);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}