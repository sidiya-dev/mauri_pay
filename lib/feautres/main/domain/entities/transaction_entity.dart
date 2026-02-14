class TransactionEntity {
  final int transactionId;
  final String senderId;
  final String receiverId;
  final double amount;
  final String transactionType;
  final DateTime createdAt;

  const TransactionEntity({
    required this.transactionId,
    required this.senderId,
    required this.receiverId,
    required this.amount,
    required this.transactionType,
    required this.createdAt,
  });

  factory TransactionEntity.fromJson(Map<String, dynamic> json) {
    return TransactionEntity(
      transactionId: json['transaction_id'] as int,
      senderId: json['sender_id'] as String,
      receiverId: json['receiver_id'] as String,
      amount: (json['amount'] as num).toDouble(),
      transactionType: json['transaction_type'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'transaction_id': transactionId,
      'sender_id': senderId,
      'receiver_id': receiverId,
      'amount': amount,
      'transaction_type': transactionType,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
