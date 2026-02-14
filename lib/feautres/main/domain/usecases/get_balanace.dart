import 'package:fpdart/src/either.dart';
import 'package:mauri_pay/core/error/failure.dart';
import 'package:mauri_pay/core/usecase/usecase.dart';
import 'package:mauri_pay/feautres/main/domain/repositories/main_repository.dart';

class GetBalanaceUsecase implements Usecase<int, String> {
  final MainRepository mainRepository;

  GetBalanaceUsecase({required this.mainRepository});

  @override
  Future<Either<Failure, int>> call(String user_id) {
    return mainRepository.getBalance(user_id);
  }
}