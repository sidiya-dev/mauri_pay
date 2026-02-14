import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mauri_pay/core/theme/app_colors.dart';
import 'package:mauri_pay/feautres/auth/presentation/bloc/auth_bloc.dart';
import 'package:mauri_pay/feautres/main/presentation/bloc/list_transaction_bloc.dart';
import 'package:mauri_pay/feautres/main/presentation/pages/Trancations/Widgets/list_transactions_widget.dart';
import 'package:mauri_pay/feautres/main/presentation/pages/Trancations/Widgets/transactions_widget.dart';
import 'package:mauri_pay/init_dependencies.dart';

class TransactionsPage extends StatelessWidget {
  const TransactionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authState = context.watch<AuthBloc>().state;

    if (authState is! Success) {
      return const Scaffold(
        body: Center(child: Text('User not authenticated')),
      );
    }

    final userId = authState.user.userId;

    return BlocProvider<ListTransactionBloc>(
      create: (_) => sl<ListTransactionBloc>(param1: userId)
        ..add(LoadTransactions()),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            BlocBuilder<ListTransactionBloc, ListTransactionState>(
              builder: (context, state) {
                double income = 0;
                double expense = 0;

                if (state is ListTransactionLoaded) {
                  for (var t in state.transactions) {
                    if (t.senderId == userId) {
                      expense += t.amount;
                    } else {
                      income += t.amount;
                    }
                  }
                }

                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: TransactionsWidget(
                        type: TransactionType.income,
                        amount: income.toDouble(),
                        title: "Income",
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TransactionsWidget(
                        type: TransactionType.outcome,
                        amount: expense.toDouble(),
                        title: "Expense",
                      ),
                    ),
                  ],
                );
              },
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

            BlocBuilder<ListTransactionBloc, ListTransactionState>(
              builder: (context, state) {
                if (state is ListTransactionLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ListTransactionError) {
                  return Text(
                    state.message,
                    style: const TextStyle(color: Colors.red),
                  );
                } else if (state is ListTransactionLoaded) {
                  if (state.transactions.isEmpty) {
                    return const Text("No transactions yet");
                  }

                  return Column(
                    children: state.transactions.map((t) {
                      final type = t.senderId == userId
                          ? ListTransactionType.outcome
                          : ListTransactionType.income;

                      final title = t.transactionType == 'transfer'
                          ? 'Transfer'
                          : 'Request';

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: ListTransactionsWidget(
                          type: type,
                          amount: t.amount.toInt(),
                          title: title,
                          date: t.createdAt,
                        ),
                      );
                    }).toList(),
                  );
                }

                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}
