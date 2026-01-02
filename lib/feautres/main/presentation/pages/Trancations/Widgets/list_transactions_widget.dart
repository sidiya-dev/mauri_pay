import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum ListTransactionType {INCOME,OUTCOME}
class ListTransactionsWidget extends StatelessWidget {
  ListTransactionsWidget({super.key,required this.type});
  final formatter = NumberFormat.currency(symbol:"\$");

  final ListTransactionType type;
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal:7.0 ,vertical:10.0 ),
      child: Row(
        children: [   
            CircleAvatar(
              child: Icon(type==ListTransactionType.INCOME ? Icons.arrow_outward:Icons.subdirectory_arrow_right),
              backgroundColor: type==ListTransactionType.INCOME? Colors.green:Colors.redAccent ,
            ),
            SizedBox(width: 10.0,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Salary Deposit"),
                    Row(
                      children: [
                        Text(type==ListTransactionType.INCOME ?"Income":"Outcome"),
                        Text(". Dec 25, 2025")
                      ],
                    ),          
                  ],
                ),
                SizedBox(width: 60,),
                Text(formatter.format(type==ListTransactionType.INCOME?544.42:-290.11),
                  style: TextStyle(
                    color: type==ListTransactionType.INCOME?Colors.green:Colors.redAccent,
                    fontSize: 18, 
                  ),
                ),
              ],
              
            ),
      ],

      ),            
    );
  }
}