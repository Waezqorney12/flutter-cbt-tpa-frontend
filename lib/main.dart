import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:test_potensial/features/auth/bloc/auth_bloc.dart';
import 'package:test_potensial/features/onboarding/domain/repository/onboarding_repository.dart';
import 'package:test_potensial/init_dependencies.dart';
import 'package:test_potensial/my_app.dart';

Future<void> main() async {
  // Used for loading .env file from root project, so it's more safe to store sensitive data
  await dotenv.load(fileName: '.env');
  await initDependencies();

  // Used for checking if the app is first install or not
  final onBoardingRepository = getIt<OnboardingRepository>();
  bool getFirstInstall = await onBoardingRepository.getOnboarding();

  // Run the app
  runApp(
    MultiBlocProvider(providers: [
      BlocProvider(
        create: (_) => getIt<AuthBloc>(),
      ),
    ], child: MyApp(getFirstInstall: getFirstInstall)),
  );
}
