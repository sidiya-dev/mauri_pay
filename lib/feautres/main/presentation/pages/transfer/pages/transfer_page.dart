import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mauri_pay/core/theme/app_colors.dart';
import 'package:mauri_pay/feautres/auth/presentation/bloc/auth_bloc.dart';
import 'package:mauri_pay/feautres/main/domain/entities/make_transaction_entity.dart';
import 'package:mauri_pay/feautres/main/presentation/bloc/make_transaction_bloc.dart';
import 'package:mauri_pay/init_dependencies.dart';

class TransferPage extends StatefulWidget {
  const TransferPage({super.key});

  @override
  State<TransferPage> createState() => _TransferPageState();
}

class _TransferPageState extends State<TransferPage> {
  final _formKey = GlobalKey<FormState>();
  final _numberController = TextEditingController();
  final _amountController = TextEditingController();

  @override
  void dispose() {
    _numberController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _onTransfer(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      final authState = context.read<AuthBloc>().state;

      if (authState is Success) {
        final transaction = MakeTransactionEntity(
          senderId: authState.user.userId,
          receiverPhone: _numberController.text.trim(),
          amount: double.parse(_amountController.text.trim()),
          transactionTypeId: 1,
        );

        context.read<MakeTransactionBloc>().add(
          MakeTransactionRequested(transaction),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("User not authenticated")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = context.watch<AuthBloc>().state;

    String userId = "";
    if (authState is Success) {
      userId = authState.user.userId;
    }

    return BlocProvider<MakeTransactionBloc>(
      create: (context) => sl<MakeTransactionBloc>(param1: userId),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Transfer'),
          backgroundColor: AppColors.backgroundColor,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: BlocConsumer<MakeTransactionBloc, MakeTransactionState>(
            listener: (context, state) {
              if (state is MakeTransactionSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Transaction Success")),
                );
                _formKey.currentState?.reset();
              } else if (state is MakeTransactionFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.error)),
                );
              }
            },
            builder: (context, state) {
              if (state is MakeTransactionLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              return Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _numberController,
                      keyboardType: TextInputType.number,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        labelText: 'Recipient Number',
                        labelStyle: TextStyle(color: Colors.white),
                        prefixIcon: Icon(Icons.phone, color: Colors.white),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter recipient number';
                        }
                        if (!RegExp(r'^[234]\d{7}$').hasMatch(value)) {
                          return 'Number must start with 2, 3, or 4 and be 8 digits';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _amountController,
                      keyboardType: TextInputType.number,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        labelText: 'Amount',
                        labelStyle: TextStyle(color: Colors.white),
                        prefixIcon: Icon(Icons.money, color: Colors.white),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter amount';
                        }
                        final number = double.tryParse(value);
                        if (number == null || number <= 0) {
                          return 'Enter a valid amount';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 32),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => _onTransfer(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.accentOrange,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Transfer',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
