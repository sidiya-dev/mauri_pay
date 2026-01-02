import 'package:flutter/material.dart';
import 'package:mauri_pay/feautres/main/presentation/pages/Trancations/Widgets/list_transactions_widget.dart';
import 'package:mauri_pay/feautres/main/presentation/pages/Trancations/Widgets/transactions_widget.dart';
class TransactionsPage extends StatelessWidget {
  const TransactionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
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
          SizedBox(height: 20.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Recent Transactions ",
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
              ),
              ElevatedButton(onPressed: () {
                
              }, child: Text(" See All",style: TextStyle( color: Colors.blue),
              ),
              ),
            ],
          ),
          SizedBox(height: 20.0,),
          Text("Recent Transactions ",
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),

          Container(
            margin: EdgeInsets.all(7.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(9),
              color: const Color.fromARGB(255, 84, 85, 86),
            ),
            child: Column(
                children: [
                  ListTransactionsWidget(type: ListTransactionType.INCOME),
                  ListTransactionsWidget(type: ListTransactionType.OUTCOME),
                  ListTransactionsWidget(type: ListTransactionType.INCOME),
                  ListTransactionsWidget(type: ListTransactionType.OUTCOME),
                  ListTransactionsWidget(type: ListTransactionType.INCOME),
                  ListTransactionsWidget(type: ListTransactionType.OUTCOME),
                  ListTransactionsWidget(type: ListTransactionType.INCOME),
                  ListTransactionsWidget(type: ListTransactionType.OUTCOME),
                ],
            ),
          ),  
        ],
      
      ),
    

      
    );
  }
}