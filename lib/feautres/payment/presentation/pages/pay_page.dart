import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart' hide TextDirection;
import 'package:mauri_pay/core/error/error_messages.dart';
import 'package:mauri_pay/core/theme/app_colors.dart';
import 'package:mauri_pay/core/utils/show_snackbar.dart';
import 'package:mauri_pay/feautres/auth/presentation/widgets/auth_botton.dart';
import 'package:mauri_pay/feautres/auth/presentation/widgets/auth_filed.dart';
import 'package:mauri_pay/feautres/payment/domain/entities/payment_preview_entity.dart';
import 'package:mauri_pay/feautres/payment/presentation/bloc/payment_bloc.dart';
import 'package:mauri_pay/init_dependencies.dart';
import 'package:mauri_pay/l10n/app_localizations.dart';
import 'package:mauri_pay/widgets/loading_widget.dart';

class PayPage extends StatelessWidget {
  const PayPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PaymentBloc>(
      create: (_) => sl<PaymentBloc>(),
      child: const _PayView(),
    );
  }
}

class _PayView extends StatefulWidget {
  const _PayView();

  @override
  State<_PayView> createState() => _PayViewState();
}

class _PayViewState extends State<_PayView> {
  final _codeController = TextEditingController();
  final _passwordController = TextEditingController();
  final _codeFormKey = GlobalKey<FormState>();
  final _passwordFormKey = GlobalKey<FormState>();

  // 0 = enter code, 1 = confirm amount, 2 = password, 3 = success
  int _step = 0;

  @override
  void dispose() {
    _codeController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(t.pay)),
      body: BlocConsumer<PaymentBloc, PaymentState>(
        listener: (context, state) {
          if (state is PaymentPreviewLoaded) {
            setState(() => _step = 1);
          } else if (state is PaymentPaid) {
            setState(() => _step = 3);
          } else if (state is PaymentFailure) {
            showSnackBar(context, localizedError(t, state.code, state.message));
          }
        },
        builder: (context, state) {
          if (state is PaymentLoading || state is PaymentPaying) {
            return beautifulLoading();
          }
          return Padding(
            padding: const EdgeInsets.all(20),
            child: switch (_step) {
              1 => _confirmStep(context, t, _previewOf(state)),
              2 => _passwordStep(context, t, _previewOf(state)),
              3 => _successStep(context, t, _previewOf(state)),
              _ => _codeStep(context, t),
            },
          );
        },
      ),
    );
  }

  PaymentPreviewEntity? _previewOf(PaymentState state) {
    if (state is PaymentPreviewLoaded) return state.preview;
    if (state is PaymentPaying) return state.preview;
    if (state is PaymentPaid) return state.preview;
    if (state is PaymentFailure) return state.preview;
    return null;
  }

  Widget _codeStep(BuildContext context, AppLocalizations t) {
    return Form(
      key: _codeFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 20),
          Icon(Icons.qr_code_2, size: 72, color: AppColors.accentOrange),
          const SizedBox(height: 16),
          Text(t.pay_enter_code_title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 24),
          AuthFiled(
            controller: _codeController,
            hintText: t.pay_code_hint,
            prefixIcon: const Icon(Icons.confirmation_number_outlined),
            isObscure: false,
            textInputType: TextInputType.text,
            validator: (v) =>
                (v == null || v.trim().isEmpty) ? t.pay_code_required : null,
          ),
          const SizedBox(height: 24),
          AuthBotton(
            text: t.next,
            onPressed: () {
              if (_codeFormKey.currentState!.validate()) {
                context
                    .read<PaymentBloc>()
                    .add(LoadPreview(_codeController.text.trim().toUpperCase()));
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _confirmStep(
      BuildContext context, AppLocalizations t, PaymentPreviewEntity? preview) {
    if (preview == null) return _codeStep(context, t);
    final amount = NumberFormat("#,##0.00").format(preview.amount);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 20),
        Text(t.pay_amount_to_pay, textAlign: TextAlign.center),
        const SizedBox(height: 8),
        // Read-only amount — fixed by the merchant.
        Text("$amount ${preview.currency}",
            textAlign: TextAlign.center,
            textDirection: TextDirection.ltr,
            style: const TextStyle(fontSize: 34, fontWeight: FontWeight.bold)),
        const SizedBox(height: 24),
        _infoRow(t.pay_merchant, preview.merchantName),
        const Divider(),
        _infoRow(t.pay_code_label, preview.code),
        const Spacer(),
        AuthBotton(
          text: t.next,
          onPressed: () => setState(() => _step = 2),
        ),
        const SizedBox(height: 12),
      ],
    );
  }

  Widget _passwordStep(
      BuildContext context, AppLocalizations t, PaymentPreviewEntity? preview) {
    if (preview == null) return _codeStep(context, t);
    final amount = NumberFormat("#,##0.00").format(preview.amount);
    return Form(
      key: _passwordFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 20),
          Icon(Icons.lock_outline, size: 56, color: AppColors.accentOrange),
          const SizedBox(height: 12),
          Text(t.pay_enter_password,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          const SizedBox(height: 4),
          Text("$amount ${preview.currency} → ${preview.merchantName}",
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.grey)),
          const SizedBox(height: 24),
          AuthFiled(
            controller: _passwordController,
            hintText: t.password_placeholder,
            prefixIcon: const Icon(Icons.lock),
            isObscure: true,
            maxLength: 6,
            textInputType: TextInputType.number,
            validator: (v) {
              if (v == null || v.isEmpty) return t.password_error_empty;
              if (!RegExp(r'^\d{6}$').hasMatch(v)) return t.password_error_invalid;
              return null;
            },
          ),
          const SizedBox(height: 12),
          AuthBotton(
            text: t.pay_confirm,
            onPressed: () {
              if (_passwordFormKey.currentState!.validate()) {
                context.read<PaymentBloc>().add(PayRequested(
                      code: preview.code,
                      password: _passwordController.text,
                    ));
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _successStep(
      BuildContext context, AppLocalizations t, PaymentPreviewEntity? preview) {
    final amount =
        preview == null ? '' : NumberFormat("#,##0.00").format(preview.amount);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Spacer(),
        const Icon(Icons.check_circle, size: 96, color: Colors.green),
        const SizedBox(height: 16),
        Text(t.pay_success,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        if (preview != null) ...[
          const SizedBox(height: 8),
          Text("$amount ${preview.currency} → ${preview.merchantName}",
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.grey)),
        ],
        const Spacer(),
        AuthBotton(text: t.pay_done, onPressed: () => context.go('/')),
        const SizedBox(height: 12),
      ],
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey)),
          Flexible(
            child: Text(value,
                textAlign: TextAlign.end,
                style: const TextStyle(fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }
}
