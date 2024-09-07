import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_potensial/core/cubit/user_cubit.dart';
import 'package:test_potensial/core/routes/routes_pages.dart';
import 'package:test_potensial/core/shared/widget/loading_widget.dart';
import 'package:test_potensial/core/utils/log.dart';
import 'package:test_potensial/features/auth/presentation/login_screen.dart';
//import 'package:test_potensial/core/utils/log.dart';
import 'package:test_potensial/features/bottom_navigator/bottom_navigator_widget.dart';
import 'package:test_potensial/features/onboarding/presentation/onboarding_screen.dart';

import 'core/theme/app_theme.dart';

class MyApp extends StatelessWidget {
  final bool getFirstInstall;
  const MyApp({super.key, required this.getFirstInstall});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightMode,
      home: BlocConsumer<UserCubit, UserState>(
        listener: (context, state) {
          if (state is UserError || state is UserLoggeoOut) Navigator.pushReplacement(context, Routes.login());
        },
        buildWhen: (previous, current) {
          if (previous is UserLoggedIn && current is UserLoggedIn) {
            return false;
          }
          return true;
        },
        builder: (context, state) {
          Log.loggerWarning('causing rebuild here: $state');
          if (getFirstInstall == true) {
            switch (state) {
              case UserLoading():
                return const Scaffold(body: Loading());
              case UserLoggedIn():
                return BottomNavigatorWidget();
              default:
                return const LoginScreen();
            }
          } else {
            return const OnBoardingScreen();
          }
        },
      ),
    );
  }
}
