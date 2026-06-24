import 'package:fpdart/fpdart.dart';
import 'package:mauri_pay/core/error/failure.dart';
import 'package:mauri_pay/feautres/payment/domain/entities/payment_preview_entity.dart';

abstract interface class PaymentRepository {
  Future<Either<Failure, PaymentPreviewEntity>> getPreview(String code);
  Future<Either<Failure, bool>> pay(String code, String password);
}
