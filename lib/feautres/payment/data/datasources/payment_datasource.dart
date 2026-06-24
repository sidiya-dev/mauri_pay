import 'package:mauri_pay/feautres/payment/domain/entities/payment_preview_entity.dart';

abstract interface class PaymentDatasource {
  Future<PaymentPreviewEntity> getPreview(String code);
  Future<void> pay(String code, String password);
}
