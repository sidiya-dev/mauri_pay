import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mauri_pay/feautres/auth/presentation/bloc/auth_bloc.dart';
import 'package:mauri_pay/feautres/main/presentation/bloc/main_bloc.dart';
import 'package:mauri_pay/feautres/main/presentation/cubit/main_cubit.dart';
import 'package:mauri_pay/feautres/main/presentation/pages/home/home_page.dart';
import 'package:mauri_pay/feautres/main/presentation/pages/profile/profile_page.dart';
import 'package:mauri_pay/feautres/main/presentation/pages/Trancations/transactions_page.dart';
import 'package:mauri_pay/feautres/main/presentation/widgets/bottom_navigation_bar_widget.dart';
import 'package:mauri_pay/feautres/main/presentation/widgets/drawer_widget.dart';
import 'package:mauri_pay/init_dependencies.dart';

List<Widget> _pages = [HomePage(), TransactionsPage(), ProfilePage()];

class WidgetTree extends StatelessWidget {
  const WidgetTree({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => MainCubit()),
        BlocProvider(
          create: (context) {
            final authState = context.read<AuthBloc>().state;
            if (authState is Success) {
              return sl<MainBloc>(param1: authState.user.userId)
                ..add(GetBalanceEvent());
            }
            return sl<MainBloc>(param1: 0);
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Icon(Icons.notifications),
            ),
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
        drawer: DrawerWidget(),
      ),
    );
  }
}
