import 'package:fpdart/fpdart.dart';
import 'package:mauri_pay/core/error/failure.dart';
import 'package:mauri_pay/core/usecase/usecase.dart';
import 'package:mauri_pay/feautres/payment/domain/repositories/payment_repository.dart';

class PayCode implements Usecase<bool, PayCodeParams> {
  final PaymentRepository repository;

  PayCode({required this.repository});

  @override
  Future<Either<Failure, bool>> call(PayCodeParams params) {
    return repository.pay(params.code, params.password);
  }
}

class PayCodeParams {
  final String code;
  final String password;

  PayCodeParams({required this.code, required this.password});
}
