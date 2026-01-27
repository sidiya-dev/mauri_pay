class MakeTransactionEntity {
  final double amount;
  final int senderId;
  final String receiverPhone;
  final int transactionTypeId;

  MakeTransactionEntity({
    required this.amount,
    required this.senderId,
    required this.receiverPhone,
    required this.transactionTypeId,
  });
}
