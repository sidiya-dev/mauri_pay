import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mauri_pay/feautres/main/presentation/pages/home/widgets/option_card_widget.dart';
import 'package:mauri_pay/feautres/main/presentation/pages/home/widgets/solde_widget.dart';
import 'package:mauri_pay/l10n/app_localizations.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SoldeWidgets(),
          const SizedBox(height: 24),
          GridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 1.1,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: [
              OptionCardWidget(
                icon: Icons.repeat_rounded,
                text: t.transfer,
                onTap: () => context.push("/transfer"),
              ),
              OptionCardWidget(
                icon: Icons.monetization_on_outlined,
                text: t.request_money,
                onTap: () => context.push("/request"),
              ),
              OptionCardWidget(
                icon: Icons.qr_code_2,
                text: t.pay,
                onTap: () => context.push("/pay"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
