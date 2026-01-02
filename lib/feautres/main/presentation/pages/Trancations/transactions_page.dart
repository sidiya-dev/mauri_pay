import 'package:flutter/material.dart';
import 'package:mauri_pay/feautres/main/presentation/pages/Trancations/Widgets/transactions_widget.dart';
class TransactionsPage extends StatelessWidget {
  const TransactionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 165.0,
            padding:EdgeInsets.symmetric(horizontal: 20,vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color.fromARGB(107, 95, 97, 98),
            ),
            child:TransactionsWidget(type: TransactionType.OUTCOME),
          ),
          Container(
            width: 165.0,
            padding:EdgeInsets.symmetric(horizontal: 20,vertical: 10),
             decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color.fromARGB(107, 95, 97, 98),
            ),
            child:TransactionsWidget(type: TransactionType.INCOME),
          ),

        ],
      ),
    );
  }
}