import 'package:fpdart/fpdart.dart';
import 'package:mauri_pay/core/error/failure.dart';
import 'package:mauri_pay/core/usecase/usecase.dart';
import 'package:mauri_pay/feautres/main/domain/entities/transaction_entity.dart';
import 'package:mauri_pay/feautres/main/domain/repositories/transaction_repository.dart';

class ListTransaction implements Usecase<List<TransactionEntity>, String> {
  final TransactionRepository repository;

  ListTransaction({required this.repository});

  @override
  Future<Either<Failure, List<TransactionEntity>>> call(String userId) {
    return repository.getTransactions(userId);
  }
}