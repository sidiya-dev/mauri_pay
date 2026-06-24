import 'package:fpdart/fpdart.dart';
import 'package:mauri_pay/core/error/failure.dart';
import 'package:mauri_pay/core/usecase/usecase.dart';
import 'package:mauri_pay/feautres/payment/domain/entities/payment_preview_entity.dart';
import 'package:mauri_pay/feautres/payment/domain/repositories/payment_repository.dart';

class GetPaymentPreview implements Usecase<PaymentPreviewEntity, String> {
  final PaymentRepository repository;

  GetPaymentPreview({required this.repository});

  @override
  Future<Either<Failure, PaymentPreviewEntity>> call(String code) {
    return repository.getPreview(code);
  }
}
