import 'package:fpdart/fpdart.dart';
import 'package:mauri_pay/core/error/failure.dart';
import 'package:mauri_pay/core/usecase/usecase.dart';
import 'package:mauri_pay/feautres/main/domain/repositories/main_repository.dart';

/// Deposit money into the current user's own account; returns the new balance.
class DepositUsecase implements Usecase<double, double> {
  final MainRepository mainRepository;

  DepositUsecase({required this.mainRepository});

  @override
  Future<Either<Failure, double>> call(double amount) {
    return mainRepository.deposit(amount);
  }
}
