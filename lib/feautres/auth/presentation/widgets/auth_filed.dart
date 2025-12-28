import 'package:flutter/material.dart';

class AuthFiled extends StatelessWidget {
  const AuthFiled({
    super.key,
    required this.controller,
    required this.hintText,
    required this.prefixIcon,
    this.isObscure = false,
    required this.validator,
    required this.maxLength,
  });
  final TextEditingController controller;
  final String hintText;
  final Icon prefixIcon;
  final bool isObscure;
  final int maxLength;
  final String? Function(String?) validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.number,
      controller: controller,
      decoration: InputDecoration(prefixIcon: prefixIcon, hintText: hintText),
      obscureText: isObscure,
      validator: validator,
      maxLength: maxLength,
    );
  }
}
