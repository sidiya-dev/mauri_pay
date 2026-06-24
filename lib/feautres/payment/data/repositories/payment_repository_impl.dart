import 'package:fpdart/fpdart.dart';
import 'package:mauri_pay/core/error/exceptions.dart';
import 'package:mauri_pay/core/error/failure.dart';
import 'package:mauri_pay/feautres/payment/data/datasources/payment_datasource.dart';
import 'package:mauri_pay/feautres/payment/domain/entities/payment_preview_entity.dart';
import 'package:mauri_pay/feautres/payment/domain/repositories/payment_repository.dart';

class PaymentRepositoryImpl implements PaymentRepository {
  final PaymentDatasource paymentDatasource;

  PaymentRepositoryImpl({required this.paymentDatasource});

  @override
  Future<Either<Failure, PaymentPreviewEntity>> getPreview(String code) async {
    try {
      final preview = await paymentDatasource.getPreview(code);
      return Right(preview);
    } on ServerException catch (e) {
      return Left(Failure(message: e.message, code: e.code));
    }
  }

  @override
  Future<Either<Failure, bool>> pay(String code, String password) async {
    try {
      await paymentDatasource.pay(code, password);
      return const Right(true);
    } on ServerException catch (e) {
      return Left(Failure(message: e.message, code: e.code));
    }
  }
}
