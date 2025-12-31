import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mauri_pay/feautres/main/presentation/pages/home/widgets/option_card_widget.dart';
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
          SizedBox(height: 15),
          GridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            shrinkWrap: true,
            children: [
              OptionCardWidget(
                icon: Icons.repeat_rounded,
                text: "Transfer",
                onTap: () => context.push("/Transfer"),
              ),
              OptionCardWidget(
                icon: Icons.monetization_on_outlined,
                text: "Request Money",
                onTap: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
