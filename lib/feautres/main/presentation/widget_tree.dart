import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mauri_pay/feautres/main/presentation/cubit/main_cubit.dart';
import 'package:mauri_pay/feautres/main/presentation/pages/home/home_page.dart';
import 'package:mauri_pay/feautres/main/presentation/pages/profile/profile_page.dart';
import 'package:mauri_pay/feautres/main/presentation/pages/Trancations/transactions_page.dart';
import 'package:mauri_pay/feautres/main/presentation/widgets/bottom_navigation_bar_widget.dart';

List<Widget> _pages = [
  HomePage(),
  TransactionsPage(),
  ProfilePage(),
];

class WidgetTree extends StatelessWidget {
  const WidgetTree({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MainCubit(),
      child: Scaffold(
        appBar: AppBar(          
          actions: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Icon(Icons.notifications),
            )
          ], 
          
        ),
        body: BlocBuilder<MainCubit, int>(
          builder: (context, selectedIndex) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: _pages.elementAt(selectedIndex),
            );
          },
        ),
        bottomNavigationBar: BottomNavigationBarWidget(),
        drawer: Drawer(),
      ),
    );
  }
}
