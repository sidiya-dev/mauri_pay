import 'package:fpdart/src/either.dart';
import 'package:mauri_pay/core/error/failure.dart';
import 'package:mauri_pay/core/usecase/usecase.dart';
import 'package:mauri_pay/feautres/main/domain/repositories/transaction_repository.dart';

class MakeTransaction
    implements Usecase<bool, MakeTransactionType> {
  final TransactionRepository makeTransactionRepository;

  MakeTransaction({required this.makeTransactionRepository});

  @override
  Future<Either<Failure, bool>> call(
    MakeTransactionType params,
  ) async {
    return await makeTransactionRepository.makeTransaction(params);
  }
}

class MakeTransactionType {
  final double amount;
  final String senderId;
  final String receiverPhone;
  final String transactionType;

  MakeTransactionType({
    required this.amount,
    required this.senderId,
    required this.receiverPhone,
    required this.transactionType,
  });
}

