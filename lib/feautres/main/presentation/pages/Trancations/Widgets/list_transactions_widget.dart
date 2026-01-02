import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum TransactionType {INCOME,OUTCOME}
class ListTransactionsWidget extends StatelessWidget {
  ListTransactionsWidget({super.key,required this.type});
  final formatter = NumberFormat.currency(symbol:"\$");

  final TransactionType type;
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(9),
        color: const Color.fromARGB(255, 84, 85, 86),
      ),
      child: Row(
        children: [
            CircleAvatar(
              child: Icon(type==TransactionType.INCOME ? Icons.arrow_outward:Icons.subdirectory_arrow_right),
              backgroundColor: type==TransactionType.INCOME? Colors.green:Colors.redAccent ,

            )
      ],),            
    );
  }
}