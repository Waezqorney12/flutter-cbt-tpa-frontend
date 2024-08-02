import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_potensial/core/cubit/user_cubit.dart';
import 'package:test_potensial/core/routes/routes_pages.dart';
import 'package:test_potensial/core/shared/widget/loading_widget.dart';
import 'package:test_potensial/features/bottom_navigator/bottom_navigator_widget.dart';
import 'package:test_potensial/features/onboarding/presentation/onboarding_screen.dart';

import 'core/theme/app_theme.dart';

class MyApp extends StatefulWidget {
  final bool getFirstInstall;
  const MyApp({super.key, required this.getFirstInstall});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    context.read<UserCubit>().getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightMode,
      home: BlocListener<UserCubit, UserState>(
        listener: (context, state) {
          if (state is UserError) Navigator.pushReplacement(context, Routes.login());
        },
        child: BlocBuilder<UserCubit, UserState>(
          builder: (context, state) {
            if (!widget.getFirstInstall) return const OnBoardingScreen();
            if (widget.getFirstInstall && state is UserSuccess) {
              return BottomNavigatorWidget();
            } else {
              return const Scaffold(body: Loading());
            }
          },
        ),
      ),
    );
  }
}
