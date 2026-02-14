import 'package:mauri_pay/feautres/main/domain/entities/make_transaction_entity.dart';

class MakeTransactionModel extends MakeTransactionEntity {
  MakeTransactionModel({
    required super.amount,
    required super.senderId,
    required super.receiverPhone,
    required super.transactionTypeId,
  });

  Map<String, dynamic> toJson() {
    return {
      'sender_id': senderId,
      'receiver_phone': receiverPhone,
      'amount': amount,
      'transaction_type_id': transactionTypeId,
    };
  }

  factory MakeTransactionModel.fromJson(Map<String, dynamic> json) {
    return MakeTransactionModel(
      amount: (json['amount'] as num).toDouble(),
      senderId: json['sender_id'] as String,
      receiverPhone: json['receiver_phone'] as String,
      transactionTypeId: json['transaction_type_id'] as int,
    );
  }
}
