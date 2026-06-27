import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mauri_pay/core/error/error_messages.dart';
import 'package:mauri_pay/core/theme/app_colors.dart';
import 'package:mauri_pay/core/utils/show_snackbar.dart';
import 'package:mauri_pay/core/utils/text_utils.dart';
import 'package:mauri_pay/feautres/auth/domain/usecases/register_usecase.dart';
import 'package:mauri_pay/feautres/auth/presentation/bloc/auth_bloc.dart';
import 'package:mauri_pay/feautres/auth/presentation/widgets/auth_botton.dart';
import 'package:mauri_pay/feautres/auth/presentation/widgets/auth_filed.dart';
import 'package:mauri_pay/l10n/app_localizations.dart';

import '../../../../widgets/loading_widget.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmController.dispose();
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
            showSnackBar(context, localizedError(t, state.code, state.message));
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
                    Image.asset("assets/images/mauri_pay.png", height: 160),
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        t.sign_up,
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 24),
                    AuthFiled(
                      controller: firstNameController,
                      hintText: "First name",
                      prefixIcon: Icon(Icons.person),
                      textInputType: TextInputType.name,
                      textCapitalization: TextCapitalization.words,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "First name is required";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 15),
                    AuthFiled(
                      controller: lastNameController,
                      hintText: "Last name",
                      prefixIcon: Icon(Icons.person_outline),
                      textInputType: TextInputType.name,
                      textCapitalization: TextCapitalization.words,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Last name is required";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 15),
                    AuthFiled(
                      controller: phoneController,
                      hintText: t.phone_placeholder,
                      prefixIcon: Icon(Icons.phone),
                      maxLength: 8,
                      isObscure: false,
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
                    SizedBox(height: 15),
                    AuthFiled(
                      controller: passwordController,
                      hintText: t.password_placeholder,
                      prefixIcon: Icon(Icons.lock),
                      maxLength: 6,
                      isObscure: true,
                      textInputType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return t.password_error_empty;
                        }
                        if (!RegExp(r'^\d{6}$').hasMatch(value)) {
                          return t.password_error_invalid;
                        }
                        if (!RegExp(r'^(?!.*(\d).*\1)\d{6}$').hasMatch(value)) {
                          return t.password_unique_error;
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 15),
                    AuthFiled(
                      controller: confirmController,
                      hintText: t.confirm_password_placeholder,
                      prefixIcon: Icon(Icons.lock),
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
                        if (value != passwordController.text) {
                          return t.password_mismatch_error;
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 15),
                    AuthBotton(
                      text: t.sign_up,
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          context.read<AuthBloc>()..add(
                            RegisterEvent(
                              params: RegisterParams(
                                firstName: capitalizeWords(
                                  firstNameController.text,
                                ),
                                lastName: capitalizeWords(
                                  lastNameController.text,
                                ),
                                phone: phoneController.text,
                                password: passwordController.text,
                              ),
                            ),
                          );
                        }
                      },
                    ),
                    SizedBox(height: 15),
                    GestureDetector(
                      onTap: () => context.go("/login"),
                      child: RichText(
                        text: TextSpan(
                          text: t.already_have_account + " ",
                          children: [
                            TextSpan(
                              text: t.sign_in,
                              style: TextStyle(color: AppColors.accentOrange),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
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
