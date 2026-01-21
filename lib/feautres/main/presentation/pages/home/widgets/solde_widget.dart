import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mauri_pay/core/theme/app_colors.dart';
import 'package:mauri_pay/core/utils/show_snackbar.dart';
import 'package:mauri_pay/feautres/auth/presentation/bloc/auth_bloc.dart';
import 'package:mauri_pay/feautres/main/presentation/bloc/main_bloc.dart';
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
                      if (value) {
                        context.read<MainBloc>().add(GetBalanceEvent());
                      }
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
                          ? BlocBuilder<MainBloc, MainState>(
                              builder: (context, state) {
                                if (state is MainLoading) {
                                  return const CircularProgressIndicator();
                                } else if (state is MainError) {
                                  WidgetsBinding.instance.addPostFrameCallback((
                                    _,
                                  ) {
                                    showSnackBar(context, state.message);
                                  });
                                  return const Text("Error");
                                } else if (state is MainSuccess) {
                                  return Text(
                                    "${state.balance} MRU",
                                    textDirection: TextDirection.ltr,
                                    style: Theme.of(
                                      context,
                                    ).textTheme.headlineSmall,
                                  );
                                }
                                return const SizedBox.shrink(); // fallback
                              },
                            )
                          : const Text("*****"),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 15),
              BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  if (state is Success) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          state.user.phone.toString(),
                          textDirection: TextDirection.ltr,
                        ),
                        Text(
                          "${state.user.firstName} ${state.user.lastName}",
                          style: const TextStyle(
                            fontSize: 16,
                            fontFamily: "Times",
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    );
                  }
                  // fallback UI
                  return const SizedBox.shrink();
                },
              ),

              SizedBox(height: 15),
            ],
          ),
        ],
      ),
    );
  }
}
