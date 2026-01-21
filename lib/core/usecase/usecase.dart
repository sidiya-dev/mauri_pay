import 'package:fpdart/fpdart.dart';
import 'package:mauri_pay/core/error/failure.dart';

abstract interface class Usecase<SuccesType, Params> {
  Future<Either<Failure, SuccesType>> call(Params params);
}