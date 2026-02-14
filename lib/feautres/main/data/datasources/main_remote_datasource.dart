abstract interface class MainRemoteDatasource {
  Future<int> getBalance(String user_id);
}