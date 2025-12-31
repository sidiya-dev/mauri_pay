import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mauri_pay/core/theme/app_theme.dart';
import 'package:mauri_pay/feautres/auth/presentation/pages/login_page.dart';
import 'package:mauri_pay/feautres/auth/presentation/pages/register_page.dart';
import 'package:mauri_pay/feautres/main/presentation/pages/home/home_page.dart';
import 'package:mauri_pay/feautres/main/presentation/pages/transfer_page.dart';
import 'package:mauri_pay/feautres/main/presentation/widget_tree.dart';

void main() {
  runApp(const MyApp());
}

final GoRouter _routes = GoRouter(
  initialLocation: "/login",
  routes: [
    GoRoute(path: "/login", builder: (_, __) => LoginPage()),
    GoRoute(path: "/register", builder: (_, __) => RegisterPage()),
    GoRoute(path: "/", builder: (_, __) => WidgetTree()),
    GoRoute(path: "/Home",builder: (_,__) => HomePage()),
    GoRoute(path: "/Transfer", builder: (_,__) => TransferPage()),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Bank System',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkThemeMode,
      routerConfig: _routes,
    );
  }
}
