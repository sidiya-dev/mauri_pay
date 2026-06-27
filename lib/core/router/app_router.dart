import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mauri_pay/feautres/auth/presentation/bloc/auth_bloc.dart';
import 'package:mauri_pay/feautres/auth/presentation/pages/login_page.dart';
import 'package:mauri_pay/feautres/auth/presentation/pages/register_page.dart';
import 'package:mauri_pay/feautres/auth/presentation/pages/splash_page.dart';
import 'package:mauri_pay/feautres/main/presentation/pages/request/request_page.dart';
import 'package:mauri_pay/feautres/main/presentation/pages/transfer/pages/transfer_page.dart';
import 'package:mauri_pay/feautres/main/presentation/pages/deposit/deposit_page.dart';
import 'package:mauri_pay/feautres/main/presentation/widget_tree.dart';
import 'package:mauri_pay/feautres/payment/presentation/pages/pay_page.dart';
import 'package:mauri_pay/init_dependencies.dart';

/// Global navigator key so non-widget code can read the navigation context.
final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

/// Router whose redirect is driven entirely by [AuthBloc] — the single source
/// of truth for whether the user is authenticated.
GoRouter buildRouter(AuthBloc authBloc) {
  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: "/splash",
    refreshListenable: GoRouterRefreshStream(authBloc.stream),
    redirect: (context, state) {
      final authState = authBloc.state;
      final loc = state.matchedLocation;
      final onAuthPages = loc == '/login' || loc == '/register';

      // Still checking the session on startup -> stay on the splash screen.
      if (authState is AuthInitial) {
        return loc == '/splash' ? null : '/splash';
      }

      // Authenticated -> keep out of splash/login/register.
      if (authState is Success) {
        return (loc == '/splash' || onAuthPages) ? '/' : null;
      }

      // Not authenticated (Unauthenticated / Error / Loading) -> only auth pages.
      return onAuthPages ? null : '/login';
    },
    routes: [
      GoRoute(path: "/splash", builder: (_, __) => const SplashPage()),
      GoRoute(path: "/login", builder: (_, __) => LoginPage()),
      GoRoute(path: "/register", builder: (_, __) => RegisterPage()),
      GoRoute(path: "/", builder: (_, __) => WidgetTree()),
      GoRoute(path: "/transfer", builder: (_, __) => TransferPage()),
      GoRoute(path: "/request", builder: (_, __) => RequestPage()),
      GoRoute(path: "/deposit", builder: (_, __) => const DepositPage()),
      GoRoute(path: "/pay", builder: (_, __) => const PayPage()),
    ],
  );
}

/// Adapts a [Stream] (the bloc's state stream) into a [Listenable] that
/// go_router can subscribe to, so navigation re-evaluates on auth changes.
class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen((_) => notifyListeners());
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

/// Built once after dependencies are initialized; used by [MaterialApp.router].
final GoRouter appRouter = buildRouter(sl<AuthBloc>());
