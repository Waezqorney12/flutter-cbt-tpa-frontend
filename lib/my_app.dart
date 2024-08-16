import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_potensial/core/cubit/user_cubit.dart';
import 'package:test_potensial/core/routes/routes_pages.dart';
import 'package:test_potensial/core/shared/widget/loading_widget.dart';
import 'package:test_potensial/core/utils/log.dart';
//import 'package:test_potensial/core/utils/log.dart';
import 'package:test_potensial/features/bottom_navigator/bottom_navigator_widget.dart';
import 'package:test_potensial/features/materi/presentation/materi_screen.dart';

import 'core/theme/app_theme.dart';

class MyApp extends StatelessWidget {
  final bool getFirstInstall;
  const MyApp({super.key, required this.getFirstInstall});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightMode,
      home: BlocListener<UserCubit, UserState>(
        listener: (context, state) {
          Log.loggerInformation('State is $state');
          if (!getFirstInstall) {
            Navigator.pushReplacement(context, Routes.onboarding());
          } else if (state is UserError || state is UserLoggeoOut) {
            Navigator.pushReplacement(context, Routes.login());
          }
        },
        child: BlocBuilder<UserCubit, UserState>(
          builder: (context, state) {
            // Log.loggerFatal('State is $state');
            // Log.loggerFatal('First Install is $getFirstInstall');
            if (state is UserInitial) context.read<UserCubit>().getUser();
            if (getFirstInstall && state is UserLoggedIn) {
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
