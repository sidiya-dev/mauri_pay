import 'package:flutter/material.dart';
import 'package:mauri_pay/core/theme/app_colors.dart';
import 'package:mauri_pay/l10n/app_localizations.dart';

class SoldeWidgets extends StatefulWidget {
  const SoldeWidgets({super.key});

  @override
  State<SoldeWidgets> createState() => _SoldeWidgetsState();
}

class _SoldeWidgetsState extends State<SoldeWidgets> {
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: LinearGradient(
          colors: [AppColors.gradiant1, AppColors.gradiant2],
        ),
      ),
      child: Stack(
        children: [
          Column(
            children: [
              SizedBox(height: 6.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset("assets/images/mauri_pay.png", height: 80),
                  Switch.adaptive(
                    value: isSwitched,
                    onChanged: (value) {
                      setState(() {
                        isSwitched = value;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.qr_code, size: 60),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        t.sold,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      isSwitched
                          ? Text(
                              "3000 MRU",
                              textDirection: TextDirection.ltr,
                              style: Theme.of(context).textTheme.headlineSmall,
                            )
                          : Text("*****"),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("36419515", textDirection: TextDirection.ltr),
                  Text(
                    "Sidiya Sidibaba",
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: "Times ",
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
            ],
          ),
        ],
      ),
    );
  }
}
