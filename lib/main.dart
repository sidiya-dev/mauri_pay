import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mauri_pay/core/router/app_router.dart';
import 'package:mauri_pay/core/theme/app_theme.dart';
import 'package:mauri_pay/cubit/cubit/locale_cubit.dart';
import 'package:mauri_pay/feautres/auth/presentation/bloc/auth_bloc.dart';
import 'package:mauri_pay/init_dependencies.dart';
import 'package:mauri_pay/l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  await initDependencies();
  // Resolve whether a session is already active before the first frame.
  sl<AuthBloc>().add(AuthCheckRequested());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LocaleCubit()),
        // .value: AuthBloc is a get_it singleton shared with the router/interceptor,
        // so the provider must not own/close its lifecycle.
        BlocProvider.value(value: sl<AuthBloc>()),
      ],
      child: BlocBuilder<LocaleCubit, Locale>(
        builder: (context, locale) {
          return MaterialApp.router(
            title: 'Bank System',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.darkThemeMode,
            locale: locale,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: [Locale('en'), Locale('fr'), Locale('ar')],
            routerConfig: appRouter,
          );
        },
      ),
    );
  }
}
