import 'package:flutter/material.dart';
import 'package:mauri_pay/feautres/main/presentation/pages/home/widgets/Solde_widgets.dart';

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

        ],
      ),
      
    );
  }
}
