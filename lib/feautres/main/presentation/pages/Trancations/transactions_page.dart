import 'package:flutter/material.dart';
import 'package:mauri_pay/core/theme/app_colors.dart';
import 'package:mauri_pay/feautres/main/presentation/pages/Trancations/Widgets/list_transactions_widget.dart';
import 'package:mauri_pay/feautres/main/presentation/pages/Trancations/Widgets/transactions_widget.dart';

class TransactionsPage extends StatelessWidget {
  const TransactionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Expanded(
                child: TransactionsWidget(
                  type: TransactionType.income,
                  amount: 7000,
                  title: "Income",
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: TransactionsWidget(
                  type: TransactionType.outcome,
                  amount: 5000,
                  title: "Expense",
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Recent Transactions",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  "See All",
                  style: TextStyle(color: AppColors.accentOrange),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Column(
            children: [
              ListTransactionsWidget(
                type: ListTransactionType.income,
                amount: 544,
                title: "Salary",
                date: DateTime.now(),
              ),
              const SizedBox(height: 12),
              ListTransactionsWidget(
                type: ListTransactionType.outcome,
                amount: 290,
                title: "Transfer",
                date: DateTime.now(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
