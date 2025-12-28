import 'package:flutter/material.dart';
import 'package:mauri_pay/core/theme/app_colors.dart';

class AuthBotton extends StatelessWidget {
  const AuthBotton({super.key, required this.text, required this.onPressed});
  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 70,
      decoration: BoxDecoration(color: AppColors.primaryGreen, borderRadius: BorderRadius.circular(10)),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent, shadowColor: Colors.transparent),
        child: Text(text, style: Theme.of(context).textTheme.bodyLarge),
      ),
    );
  }
}
