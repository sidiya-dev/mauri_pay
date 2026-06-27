import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mauri_pay/core/error/error_messages.dart';
import 'package:mauri_pay/core/theme/app_colors.dart';
import 'package:mauri_pay/core/utils/show_snackbar.dart';
import 'package:mauri_pay/feautres/auth/presentation/bloc/auth_bloc.dart';
import 'package:mauri_pay/feautres/main/presentation/bloc/main_bloc.dart';
import 'package:mauri_pay/init_dependencies.dart';
import 'package:mauri_pay/l10n/app_localizations.dart';

/// Self-deposit: enter an amount and it's credited to your own account.
class DepositPage extends StatelessWidget {
  const DepositPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authState = context.watch<AuthBloc>().state;
    if (authState is! Success) {
      return const Scaffold(body: Center(child: Text('User not authenticated')));
    }
    return BlocProvider<MainBloc>(
      create: (_) => sl<MainBloc>(param1: authState.user.userId),
      child: const _DepositView(),
    );
  }
}

class _DepositView extends StatefulWidget {
  const _DepositView();

  @override
  State<_DepositView> createState() => _DepositViewState();
}

class _DepositViewState extends State<_DepositView> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    final amount = double.parse(_amountController.text.trim());
    context.read<MainBloc>().add(DepositRequested(amount));
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: Text(t.deposit)),
      body: BlocConsumer<MainBloc, MainState>(
        listener: (context, state) {
          if (state is DepositSuccess) {
            showSnackBar(context, t.deposit_success);
            context.pop();
          } else if (state is DepositFailure) {
            showSnackBar(context, localizedError(t, state.code, state.message));
          }
        },
        builder: (context, state) {
          final loading = state is MainLoading;
          return SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 8),
                    // Hero icon
                    Container(
                      height: 72,
                      width: 72,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColors.primaryGreen.withValues(alpha: 0.15),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.add_card_rounded,
                          color: AppColors.primaryGreen, size: 34),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      t.deposit,
                      textAlign: TextAlign.center,
                      style: textTheme.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      t.deposit_amount_hint,
                      textAlign: TextAlign.center,
                      style:
                          textTheme.bodyMedium?.copyWith(color: Colors.white60),
                    ),
                    const SizedBox(height: 28),
                    TextFormField(
                      controller: _amountController,
                      keyboardType: const TextInputType.numberWithOptions(
                          decimal: true),
                      style: textTheme.headlineMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        hintText: '0.00',
                        suffixText: 'MRU',
                        suffixStyle: const TextStyle(
                            color: AppColors.primaryGreen,
                            fontWeight: FontWeight.bold),
                      ),
                      validator: (v) {
                        if (v == null || v.trim().isEmpty) {
                          return t.amount_error_empty;
                        }
                        final n = double.tryParse(v.trim());
                        if (n == null || n <= 0) return t.amount_error_invalid;
                        return null;
                      },
                    ),
                    const SizedBox(height: 32),
                    SizedBox(
                      height: 52,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryGreen,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                        ),
                        onPressed: loading ? null : _submit,
                        child: loading
                            ? const SizedBox(
                                height: 22,
                                width: 22,
                                child: CircularProgressIndicator(
                                    strokeWidth: 2.5, color: Colors.white),
                              )
                            : Text(t.deposit_button,
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                      ),
                    ),
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
