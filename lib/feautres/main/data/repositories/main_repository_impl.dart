import 'package:fpdart/fpdart.dart';
import 'package:mauri_pay/core/error/failure.dart';
import 'package:mauri_pay/feautres/main/data/datasources/main_remote_datasource.dart';
import 'package:mauri_pay/feautres/main/domain/repositories/main_repository.dart';

class MainRepositoryImpl implements MainRepository {
  final MainRemoteDatasource mainRemoteDatasource;

  MainRepositoryImpl({required this.mainRemoteDatasource});

  @override
  Future<Either<Failure, int>> getBalance(int user_id) async {
    try {
      final balance = await mainRemoteDatasource.getBalance(user_id);
      return Right(balance);
    } catch (e) {
      return Left(Failure(message: 'Failed to load balance'));
    }
  }
}
