import 'package:fpdart/src/either.dart';
import 'package:mauri_pay/core/error/failure.dart';
import 'package:mauri_pay/core/usecase/usecase.dart';
import 'package:mauri_pay/feautres/main/domain/entities/make_transaction_entity.dart';
import 'package:mauri_pay/feautres/main/domain/repositories/make_transaction_repository.dart';

class MakeTransaction
    implements Usecase<MakeTransactionEntity, MakeTransactionType> {
  final MakeTransactionRepository makeTransactionRepository;

  MakeTransaction({required this.makeTransactionRepository});

  @override
  Future<Either<Failure, MakeTransactionEntity>> call(
    MakeTransactionType params,
  ) async {
    return await makeTransactionRepository.makeTransaction(params);
  }
}

class MakeTransactionType {
  final double amount;
  final int senderId;
  final String receiverPhone;
  final int transactionTypeId;

  MakeTransactionType({
    required this.amount,
    required this.senderId,
    required this.receiverPhone,
    required this.transactionTypeId,
  });
}

