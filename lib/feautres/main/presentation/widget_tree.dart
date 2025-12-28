import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mauri_pay/feautres/main/presentation/cubit/main_cubit.dart';
import 'package:mauri_pay/feautres/main/presentation/pages/home/home_page.dart';
import 'package:mauri_pay/feautres/main/presentation/pages/profile/profile_page.dart';
import 'package:mauri_pay/feautres/main/presentation/pages/transfer/transactions_page.dart';
import 'package:mauri_pay/feautres/main/presentation/pages/transfer_page.dart';
import 'package:mauri_pay/feautres/main/presentation/widgets/bottom_navigation_bar_widget.dart';

List<Widget> _pages = [
  HomePage(),
  TransferPage(),
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
            IconButton(onPressed: () { 
            },
             icon: Icon(Icons.notifications_none_outlined),
            ),
            Spacer(flex:1),
            IconButton(onPressed: () {
            },
             icon: Icon(Icons.menu_rounded)),
            
          ], 
          
        ),
        body: BlocBuilder<MainCubit, int>(
          builder: (context, selectedIndex) {
            return _pages.elementAt(selectedIndex);
          },
        ),
        bottomNavigationBar: BottomNavigationBarWidget(),
      ),
    );
  }
}
