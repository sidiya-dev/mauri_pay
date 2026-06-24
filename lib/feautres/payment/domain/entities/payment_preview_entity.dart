class PaymentPreviewEntity {
  final String code;
  final double amount;
  final String currency;
  final String merchantName;
  final String status;

  const PaymentPreviewEntity({
    required this.code,
    required this.amount,
    required this.currency,
    required this.merchantName,
    required this.status,
  });

  factory PaymentPreviewEntity.fromJson(Map<String, dynamic> json) {
    return PaymentPreviewEntity(
      code: json['code']?.toString() ?? '',
      amount: (json['amount'] as num).toDouble(),
      currency: json['currency']?.toString() ?? 'MRU',
      merchantName: json['merchantName']?.toString() ?? '',
      status: json['status']?.toString() ?? '',
    );
  }
}
