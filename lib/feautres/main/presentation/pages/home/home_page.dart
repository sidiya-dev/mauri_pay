import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mauri_pay/feautres/main/presentation/pages/home/widgets/card_home_widget.dart';
import 'package:mauri_pay/feautres/main/presentation/pages/home/widgets/solde_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          SoldeWidgets(),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [  
            CardhomeWidget(icon:Icons.paid_outlined,text: "Paiement",onTap: () => {} ,),
            CardhomeWidget(icon:Icons.repeat_rounded,text: "Transfer",onTap:()=>context.push("/Transfer")),
          ]
          ),
         Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [  
            CardhomeWidget(icon:Icons.money_rounded,text: "Transations",onTap:()=>{} ,),
            CardhomeWidget(icon:Icons.remove_shopping_cart_sharp,text: "Recharger",onTap:()=>{} ,),
          ]  
         ),
        
        ],
      ),
      
    );
  }
}
