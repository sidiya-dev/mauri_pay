import 'package:fpdart/fpdart.dart';
import 'package:mauri_pay/core/error/failure.dart';

abstract interface class MainRepository {
  Future<Either<Failure, double>> getBalance(String user_id);
}
