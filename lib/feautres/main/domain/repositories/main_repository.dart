import 'package:fpdart/fpdart.dart';
import 'package:mauri_pay/core/error/failure.dart';

abstract interface class MainRepository {
  Future<Either<Failure, double>> getBalance(String user_id);

  /// Deposit into the current user's own account; returns the new balance.
  Future<Either<Failure, double>> deposit(double amount);
}
