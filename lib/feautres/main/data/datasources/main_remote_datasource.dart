abstract interface class MainRemoteDatasource {
  Future<double> getBalance(String user_id);
}