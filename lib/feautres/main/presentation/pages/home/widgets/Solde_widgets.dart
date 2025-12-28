import 'package:flutter/material.dart';
import 'package:mauri_pay/core/theme/app_colors.dart';

class SoldeWidgets extends StatelessWidget {
  SoldeWidgets({super.key});
  bool isSwitched=false;
  @override
  Widget build(BuildContext context) {
    
    return Container(
     decoration: BoxDecoration(
      gradient: LinearGradient(colors: 
      [const Color.fromARGB(110, 255, 128, 0),
      const Color.fromARGB(150, 190, 105, 82)])
     ),
      child:Stack(

        children:[ 
          Column(
          children: [
            Row(           
              mainAxisAlignment:MainAxisAlignment.spaceBetween,
              children: [
                Image.asset("assets/images/mauri_pay.png",height: 50,),
                Switch(value: isSwitched, onChanged: (value) {
                  isSwitched=value;
                },)
              ],
              
            ),
             Row(           
              mainAxisAlignment:MainAxisAlignment.spaceBetween,
              children: [
                IconButton(onPressed: () {  
                },
                 icon:Icon(Icons.account_balance_sharp)
                 ),
                 Text("MauriPay Bank"),
              ],
              
            ),
             Row(           
              mainAxisAlignment:MainAxisAlignment.spaceBetween,
              children: [
                IconButton(onPressed: () {  
                },
                 icon:Icon(Icons.account_balance_sharp)
                 ),
                 Text("MauriPay Bank"),
              ],
              
            ),
          ],
        ),
        ],
      ) ,
     
    );
  }
}