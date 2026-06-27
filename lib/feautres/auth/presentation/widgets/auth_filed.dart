import 'package:flutter/material.dart';
import 'package:mauri_pay/core/theme/app_colors.dart';

/// Shared auth text field. For secret fields (`isObscure: true`) it hides the
/// value by default and shows an eye toggle so the user can reveal it.
class AuthFiled extends StatefulWidget {
  const AuthFiled({
    super.key,
    required this.controller,
    required this.hintText,
    required this.prefixIcon,
    this.isObscure = false,
    required this.validator,
    this.maxLength,
    this.textInputType,
    this.textCapitalization = TextCapitalization.none,
  });

  final TextEditingController controller;
  final String hintText;
  final Icon prefixIcon;
  final bool isObscure;
  final int? maxLength;
  final String? Function(String?) validator;
  final TextInputType? textInputType;
  final TextCapitalization textCapitalization;

  @override
  State<AuthFiled> createState() => _AuthFiledState();
}

class _AuthFiledState extends State<AuthFiled> {
  late bool _hidden = widget.isObscure;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: widget.textInputType,
      controller: widget.controller,
      obscureText: _hidden,
      textCapitalization: widget.textCapitalization,
      validator: widget.validator,
      maxLength: widget.maxLength,
      decoration: InputDecoration(
        prefixIcon: widget.prefixIcon,
        hintText: widget.hintText,
        // Hide the noisy per-field counter on the short PIN/phone fields.
        counterText: '',
        suffixIcon: widget.isObscure
            ? IconButton(
                tooltip: _hidden ? 'Show' : 'Hide',
                icon: Icon(
                  _hidden ? Icons.visibility_off : Icons.visibility,
                  color: AppColors.lightOrange,
                ),
                onPressed: () => setState(() => _hidden = !_hidden),
              )
            : null,
      ),
    );
  }
}
