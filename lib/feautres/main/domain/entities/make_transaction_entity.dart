class MakeTransactionEntity {
  final double amount;
  final String senderId;
  final String receiverPhone;
  final String transactionType;

  MakeTransactionEntity({
    required this.amount,
    required this.senderId,
    required this.receiverPhone,
    required this.transactionType,
  });
}
