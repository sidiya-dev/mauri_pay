import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mauri_pay/core/theme/app_colors.dart';
import 'package:mauri_pay/core/utils/show_snackbar.dart';
import 'package:mauri_pay/feautres/auth/domain/usecases/login_usecase.dart';
import 'package:mauri_pay/feautres/auth/presentation/bloc/auth_bloc.dart';
import 'package:mauri_pay/feautres/auth/presentation/widgets/auth_botton.dart';
import 'package:mauri_pay/feautres/auth/presentation/widgets/auth_filed.dart';
import 'package:mauri_pay/l10n/app_localizations.dart';

import '../../../../widgets/loading_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  static final route = MaterialPageRoute(builder: (context) => LoginPage());

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is Error) {
            showSnackBar(context, state.message);
          } else if (state is Success) {
            context.go("/");
          }
        },
        builder: (context, state) {
          if (state is Loading) {
            return beautifulLoading();
          }

          return SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Image.asset("assets/images/mauri_pay.png", height: 220),
                    const SizedBox(height: 30),

                    AuthFiled(
                      controller: phoneController,
                      hintText: t.phone_placeholder,
                      prefixIcon: const Icon(Icons.phone),
                      maxLength: 8,
                      textInputType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return t.phone_error_empty;
                        }
                        if (!RegExp(r'^[234]\d{7}$').hasMatch(value)) {
                          return t.phone_error_invalid;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),

                    AuthFiled(
                      controller: passwordController,
                      hintText: t.password_placeholder,
                      prefixIcon: const Icon(Icons.lock),
                      isObscure: true,
                      maxLength: 6,
                      textInputType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return t.password_error_empty;
                        }
                        if (!RegExp(r'^\d{6}$').hasMatch(value)) {
                          return t.password_error_invalid;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),

                    AuthBotton(
                      text: t.sign_in,
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          context.read<AuthBloc>().add(
                            LoginEvent(
                              params: LoginParams(
                                phone: phoneController.text,
                                password: passwordController.text,
                              ),
                            ),
                          );
                        }
                      },
                    ),
                    const SizedBox(height: 15),

                    // Register Link
                    GestureDetector(
                      onTap: () => context.push("/register"),
                      child: RichText(
                        text: TextSpan(
                          text: t.dont_have_account + " ",
                          children: [
                            TextSpan(
                              text: t.sign_up,
                              style: const TextStyle(
                                color: AppColors.accentOrange,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
