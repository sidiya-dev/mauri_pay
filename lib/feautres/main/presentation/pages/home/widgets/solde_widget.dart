import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart' hide TextDirection;
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
  bool _visible = false;

  void _toggle() {
    setState(() => _visible = !_visible);
    if (_visible) {
      context.read<MainBloc>().add(GetBalanceEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.gradiant1, AppColors.gradiant2],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset("assets/images/mauri_pay.png", height: 64),
              IconButton(
                onPressed: _toggle,
                icon: Icon(
                  _visible ? Icons.visibility_off : Icons.visibility,
                  color: Colors.white,
                ),
                tooltip: t.sold,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            t.sold,
            style: textTheme.bodyMedium?.copyWith(color: Colors.white70),
          ),
          const SizedBox(height: 8),
          _BalanceText(visible: _visible, textTheme: textTheme),
          const SizedBox(height: 24),
          BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state is Success) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        "${state.user.firstName} ${state.user.lastName}",
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.titleMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Text(
                      state.user.phone.toString(),
                      textDirection: TextDirection.ltr,
                      style: textTheme.bodyMedium?.copyWith(
                        color: Colors.white70,
                      ),
                    ),
                  ],
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}

class _BalanceText extends StatelessWidget {
  final bool visible;
  final TextTheme textTheme;
  const _BalanceText({required this.visible, required this.textTheme});

  @override
  Widget build(BuildContext context) {
    final style = textTheme.displaySmall?.copyWith(
      color: Colors.white,
      fontWeight: FontWeight.bold,
    );

    if (!visible) {
      return Text("••••••", style: style);
    }

    return BlocBuilder<MainBloc, MainState>(
      builder: (context, state) {
        if (state is MainLoading) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: SizedBox(
              height: 28,
              width: 28,
              child: CircularProgressIndicator(
                strokeWidth: 2.5,
                color: Colors.white,
              ),
            ),
          );
        } else if (state is MainError) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            showSnackBar(context, state.message);
          });
          return Text("—", style: style);
        } else if (state is MainSuccess) {
          return TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: state.balance),
            duration: const Duration(milliseconds: 600),
            curve: Curves.easeOutCubic,
            builder: (context, value, _) => Text(
              "${NumberFormat("#,##0.00").format(value)} MRU",
              textDirection: TextDirection.ltr,
              style: style,
            ),
          );
        }
        return Text("••••••", style: style);
      },
    );
  }
}
