import 'package:fpdart/src/either.dart';
import 'package:mauri_pay/core/error/failure.dart';
import 'package:mauri_pay/feautres/main/data/datasources/make_transaction_datasource.dart';
import 'package:mauri_pay/feautres/main/domain/repositories/make_transaction_repository.dart';
import 'package:mauri_pay/feautres/main/domain/usecases/make_transaction.dart';

class MakeTransactionRepositoryImpl implements MakeTransactionRepository {
  final MakeTransactionDatasource makeTransactionDatasource;

  MakeTransactionRepositoryImpl({required this.makeTransactionDatasource});
  @override
  Future<Either<Failure, bool>> makeTransaction(MakeTransactionType params) async{
    try {
      final result = await makeTransactionDatasource.makeTransaction(params);
      return Right(result);
    } catch (e) {
      return Left(Failure(message: 'Failed make transaction'));
    }
  }
}