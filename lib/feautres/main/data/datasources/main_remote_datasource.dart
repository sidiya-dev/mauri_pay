abstract interface class MainRemoteDatasource {
  Future<int> getBalance(int user_id);
}