import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mauri_pay/core/theme/app_colors.dart';
import 'package:mauri_pay/feautres/main/presentation/cubit/main_cubit.dart';
import 'package:mauri_pay/l10n/app_localizations.dart';

class BottomNavigationBarWidget extends StatelessWidget {
  const BottomNavigationBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return BlocBuilder<MainCubit, int>(
      builder: (context, selectedIndex) {
        return NavigationBar(
          indicatorColor: AppColors.gradiant1,
          selectedIndex: selectedIndex,
          destinations: [
            NavigationDestination(icon: Icon(Icons.home), label: t.home),
            NavigationDestination(
              icon: Icon(Icons.history),
              label: t.transactions,
            ),
            NavigationDestination(icon: Icon(Icons.person), label: t.profile),
          ],
          onDestinationSelected: (value) =>
              context.read<MainCubit>().changeIndex(value),
        );
      },
    );
  }
}
