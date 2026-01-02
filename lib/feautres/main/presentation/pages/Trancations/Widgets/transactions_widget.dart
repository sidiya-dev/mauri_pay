import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum TransactionType {INCOME,OUTCOME}
class TransactionsWidget extends StatelessWidget {
  TransactionsWidget({super.key,required this.type});
  final formatter = NumberFormat.currency(symbol:"\$");

  final TransactionType type;
  
  @override
  Widget build(BuildContext context) {
    return Container(
      child:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 10,
        children: [
          Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                      child: Icon(type==TransactionType.INCOME ? Icons.arrow_outward:Icons.subdirectory_arrow_right),
                      backgroundColor: type==TransactionType.INCOME? Colors.green:Colors.redAccent ,
                  ), 
                  SizedBox(width: 20.0,),              
                  Text(type==TransactionType.INCOME ?"Income":"Outcome")          
                ],           
                ),
            ],
          ),
            Text(formatter.format(type==TransactionType.INCOME?544.42:-290.11),
                  style: TextStyle(
                    color: type==TransactionType.INCOME?Colors.green:Colors.redAccent,
                    fontSize: 16, 
                  ),
            ),

            
        ],
      
      ),
                  
    );
  }
}