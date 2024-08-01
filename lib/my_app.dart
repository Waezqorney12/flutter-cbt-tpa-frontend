import 'package:flutter/material.dart';
import 'package:test_potensial/features/bottom_navigator/bottom_navigator_widget.dart';
import 'package:test_potensial/features/materi/presentation/materi_screen.dart';

import 'features/auth/presentation/login_screen.dart';
import 'features/onboarding/presentation/onboarding_screen.dart';
import 'core/theme/app_theme.dart';

class MyApp extends StatelessWidget {
  final bool getFirstInstall;
  const MyApp({super.key, required this.getFirstInstall});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightMode,
      home: getFirstInstall ? LoginScreen() : const OnBoardingScreen(),
    );
  }
}
