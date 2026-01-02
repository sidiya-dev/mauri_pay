import 'package:flutter/material.dart';
import 'package:intl/intl.dart' hide TextDirection;
import 'package:mauri_pay/core/theme/app_colors.dart';

enum TransactionType { income, outcome }

class TransactionsWidget extends StatelessWidget {
  const TransactionsWidget({
    super.key,
    required this.type,
    required this.amount,
    required this.title,
  });

  final TransactionType type;
  final double amount;
  final String title;

  @override
  Widget build(BuildContext context) {
    final isIncome = type == TransactionType.income;
    final formatter = NumberFormat("#,##0");

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.grayColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 10,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 22,
                backgroundColor: (isIncome
                    ? Colors.green.withAlpha(15)
                    : Colors.red.withAlpha(15)),
                child: Icon(
                  isIncome ? Icons.trending_up : Icons.trending_down,
                  color: isIncome ? Colors.green : Colors.red,
                ),
              ),
              const SizedBox(width: 16),
              Text(
                isIncome ? "Income" : "Expense",
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
              ),
            ],
          ),
          Text(
            "${formatter.format(amount)} MRU",
            textDirection: TextDirection.ltr,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: isIncome ? Colors.green : Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
