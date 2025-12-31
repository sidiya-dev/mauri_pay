import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mauri_pay/feautres/main/presentation/cubit/main_cubit.dart';

class BottomNavigationBarWidget extends StatelessWidget {
  const BottomNavigationBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, int>(
      builder: (context, selectedIndex) {
        return NavigationBar(
          selectedIndex: selectedIndex,
          destinations: [
            NavigationDestination(icon: Icon(Icons.home), label: "Home"),
            // NavigationDestination(icon: Icon(Icons.send), label: "Transfer"),
            NavigationDestination(
              icon: Icon(Icons.history),
              label: "Transactions",
            ),
            NavigationDestination(icon: Icon(Icons.person), label: "Profile"),
          ],
          onDestinationSelected: (value) =>
              context.read<MainCubit>().changeIndex(value),
        );
      },
    );
  }
}
