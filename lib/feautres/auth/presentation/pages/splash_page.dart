import 'package:flutter/material.dart';

/// Shown briefly on startup while AuthBloc resolves whether a session is active.
class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
