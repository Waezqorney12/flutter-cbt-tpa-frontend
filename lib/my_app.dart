import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_potensial/core/cubit/user_cubit.dart';
import 'package:test_potensial/core/shared/widget/loading_widget.dart';
import 'package:test_potensial/features/auth/presentation/login_screen.dart';
import 'package:test_potensial/features/bottom_navigator/bottom_navigator_widget.dart';
import 'package:test_potensial/features/onboarding/presentation/onboarding_screen.dart';
import 'package:test_potensial/features/teacher/home_teacher/presentation/home_teacher_screen.dart';

import 'core/theme/app_theme.dart';

class MyApp extends StatelessWidget {
  final bool getFirstInstall;
  const MyApp({super.key, required this.getFirstInstall});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightMode,
      home: BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {
          if (getFirstInstall == true) {
            if (state is UserInitial) context.read<UserCubit>().getUser();
            return switch (state) {
              UserLoading() => const Scaffold(body: Loading()),
              UserLoggedIn() => state.user.roles == 'STAFF' ? const HomeTeacherScreen() : BottomNavigatorWidget(),
              _ => const LoginScreen(),
            };
          } else {
            return const OnBoardingScreen();
          }
        },
      ),
    );
  }
}
