import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:test_potensial/core/cubit/user_cubit.dart';
import 'package:test_potensial/features/auth/bloc/auth_bloc.dart';
import 'package:test_potensial/features/history_nilai/presentation/cubit/history_nilai_cubit.dart';
import 'package:test_potensial/features/materi/presentation/bloc/materi_bloc.dart';
import 'package:test_potensial/features/onboarding/domain/repository/onboarding_repository.dart';
import 'package:test_potensial/features/profile_detail/cubit/profile_detail_cubit.dart';
import 'package:test_potensial/features/quiz_detail/bloc/quiz_detail_bloc.dart';
import 'package:test_potensial/features/quiz_nilai/bloc/quiz_nilai_bloc.dart';
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
  initializeDateFormatting().then((_) => runApp(
        MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => getIt<UserCubit>()),
            BlocProvider(create: (context) => getIt<AuthBloc>()),
            BlocProvider(create: (context) => getIt<MateriBloc>()),
            BlocProvider(create: (context) => getIt<QuizDetailBloc>()),
            BlocProvider(create: (context) => getIt<QuizNilaiBloc>()),
            BlocProvider(create: (context) => getIt<HistoryNilaiCubit>()),
            BlocProvider(create: (context) => getIt<ProfileDetailCubit>()),
          ],
          child: MyApp(getFirstInstall: getFirstInstall),
        ),
      ));
}
