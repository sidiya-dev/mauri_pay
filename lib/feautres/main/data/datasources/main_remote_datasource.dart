abstract interface class MainRemoteDatasource {
  Future<double> getBalance(String user_id);

  /// Deposit money into the current user's own account. Returns the new balance.
  Future<double> deposit(double amount);
}
