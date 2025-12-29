import 'dart:ffi';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mauri_pay/core/theme/app_colors.dart';

class SoldeWidgets extends StatefulWidget {
  SoldeWidgets({super.key});

  @override
  State<SoldeWidgets> createState() => _SoldeWidgetsState();
}

class _SoldeWidgetsState extends State<SoldeWidgets> {
  bool isSwitched=false;

  @override
  Widget build(BuildContext context) {
    
    return Container(
      
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      gradient: LinearGradient(colors: 
      [
        const Color.fromARGB(134, 255, 128, 0),
        const Color.fromARGB(150, 190, 105, 82)
      ]
      )
     ),
      child:Stack(

        children:[ 
          Column(
          children: [
            SizedBox(height: 6.0,),
            Row(           
              mainAxisAlignment:MainAxisAlignment.spaceBetween,
              children: [
                Image.asset("assets/images/mauri_pay.png",
                height: 45,
                ) ,
                Switch.adaptive(value: isSwitched,
                 onChanged: (value) {
                  setState((){
                    isSwitched=value;
                  });
                  
                },
                )
              ],
            ),
            SizedBox(height: 10.0,),
             Row(           
              mainAxisAlignment:MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.qr_code,size: 40,),
                 Column(
                   children: [
                     Text("Solde",
                     style:TextStyle(fontWeight: FontWeight.bold,fontSize: 18) ,
                     ),
                      Text("*****"),
                   ],
                 ),
              ],
            ),
            SizedBox(height: 10.0,),
             Row(           
              mainAxisAlignment:MainAxisAlignment.spaceBetween,
              children: [
                 Text("49 74 40 61"),
                 Text("Med AbdelWahab Idoumou",style: TextStyle(fontSize: 16,fontFamily: "Times ",fontWeight:FontWeight.w600),),
              ],
              
            ),
            SizedBox(height: 10.0,),
          ],
        ),
        ],
      ) ,
     
    );
  }
}