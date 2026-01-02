import 'package:flutter/material.dart';
import 'package:intl/intl.dart' hide TextDirection;
import 'package:mauri_pay/core/theme/app_colors.dart';

enum ListTransactionType { income, outcome }

class ListTransactionsWidget extends StatelessWidget {
  const ListTransactionsWidget({
    super.key,
    required this.type,
    required this.amount,
    required this.title,
    required this.date,
  });

  final ListTransactionType type;
  final int amount;
  final String title;
  final DateTime date;

  @override
  Widget build(BuildContext context) {
    final isIncome = type == ListTransactionType.income;
    final formatter = NumberFormat("#,##0");
    return Card(
      color: AppColors.grayColor,
      child: ListTile(
        leading: CircleAvatar(
          radius: 22,
          backgroundColor: isIncome
              ? Colors.green.withAlpha(15)
              : Colors.red.withAlpha(15),
          child: Icon(
            isIncome ? Icons.arrow_downward : Icons.arrow_upward,
            color: isIncome ? Colors.green : Colors.red,
          ),
        ),
        title: Text(
          title,
          style: Theme.of(
            context,
          ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          DateFormat.yMMMd().format(date),
          style: Theme.of(context).textTheme.bodySmall,
        ),

        trailing: Text(
          "${formatter.format(amount)} MRU",
          textDirection: TextDirection.ltr,
          style: TextStyle(
            color: isIncome ? Colors.green : Colors.red,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
