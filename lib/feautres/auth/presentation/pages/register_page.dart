import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mauri_pay/core/theme/app_colors.dart';
import 'package:mauri_pay/feautres/auth/presentation/widgets/auth_botton.dart';
import 'package:mauri_pay/feautres/auth/presentation/widgets/auth_filed.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Image.asset("assets/images/mauri_pay.png"),
                AuthFiled(
                  controller: phoneController,
                  hintText: "Phone Number",
                  prefixIcon: Icon(Icons.phone),
                  maxLength: 8,
                  isObscure: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a number';
                    }
                    if (!RegExp(r'^[234]\d{7}$').hasMatch(value)) {
                      return 'Invalid number';
                    }

                    return null;
                  },
                ),
                SizedBox(height: 30),
                AuthFiled(
                  controller: passwordController,
                  hintText: "Password",
                  prefixIcon: Icon(Icons.lock),
                  maxLength: 4,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password';
                    }
                    if (!RegExp(r'^\d{4}$').hasMatch(value)) {
                      return 'Password must be 4 digits';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 30),
                AuthFiled(
                  controller: confirmController,
                  hintText: "Confirm Password",
                  prefixIcon: Icon(Icons.lock),
                  isObscure: true,
                  maxLength: 4,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password';
                    }
                    if (!RegExp(r'^\d{4}$').hasMatch(value)) {
                      return 'Password must be 4 digits';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 30),
                AuthBotton(
                  text: "Register",
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      context.go("/");
                    }
                  },
                ),
                SizedBox(height: 30),
                GestureDetector(
                  onTap: () => context.go("/login"),
                  child: RichText(
                    text: TextSpan(
                      text: "Already have an account? ",
                      children: [
                        TextSpan(
                          text: "Login",
                          style: TextStyle(color: AppColors.accentOrange),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
