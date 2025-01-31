import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:test_potensial/core/cubit/user_cubit.dart';
//import 'package:test_potensial/core/utils/log.dart';
import 'package:test_potensial/features/auth/bloc/auth_bloc.dart';
import 'package:test_potensial/features/auth/bloc/forgot_password_bloc.dart';
import 'package:test_potensial/features/student/history_nilai/presentation/cubit/history_nilai_cubit.dart';
import 'package:test_potensial/features/student/materi/presentation/bloc/materi_bloc.dart';
import 'package:test_potensial/features/onboarding/domain/repository/onboarding_repository.dart';
import 'package:test_potensial/features/profile_detail/cubit/profile_detail_cubit.dart';
import 'package:test_potensial/features/student/quiz/cubit/quiz_thumbnail_cubit.dart';
import 'package:test_potensial/features/student/quiz_detail/bloc/quiz_detail_bloc.dart';
import 'package:test_potensial/features/student/quiz_nilai/bloc/quiz_nilai_bloc.dart';
import 'package:test_potensial/features/teacher/home_teacher/bloc/home_teacher_bloc.dart';
import 'package:test_potensial/features/teacher/quiz_teacher_detail_form/cubit/quiz_detail_form/quiz_detail_form_cubit.dart';
import 'package:test_potensial/features/teacher/quiz_teacher_detail_form/cubit/quiz_detail_form_question/quiz_detail_form_question_cubit.dart';
import 'package:test_potensial/features/teacher/quiz_teacher_form/quiz_teacher_form_controller.dart';
import 'package:test_potensial/init_dependencies.dart';
import 'package:test_potensial/my_app.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  await dotenv.load(fileName: '.env');
  await initDependencies();

  // Used for checking if the app is first install or not
  final onBoardingRepository = getIt<OnboardingRepository>();
  bool getFirstInstall = await onBoardingRepository.getOnboarding();
  //Log.loggerInformation('First Install: $getFirstInstall');

  // Run the app
  initializeDateFormatting().then((_) => runApp(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (context) => QuizTeacherFormController(),
            )
          ],
          child: MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => getIt<UserCubit>()),
              BlocProvider(create: (context) => getIt<AuthBloc>()),
              BlocProvider(create: (context) => getIt<MateriBloc>()),
              BlocProvider(create: (context) => getIt<QuizDetailBloc>()),
              BlocProvider(create: (context) => getIt<QuizNilaiBloc>()),
              BlocProvider(create: (context) => getIt<HistoryNilaiCubit>()),
              BlocProvider(create: (context) => getIt<ProfileDetailCubit>()),
              BlocProvider(create: (context) => getIt<ForgotPasswordBloc>()),
              BlocProvider(create: (context) => getIt<QuizThumbnailCubit>()),
              BlocProvider(create: (context) => getIt<QuizDetailFormCubit>()),
              BlocProvider(create: (context) => getIt<QuizDetailFormQuestionCubit>()),
              BlocProvider(create: (context) => getIt<HomeTeacherBloc>()),
            ],
            child: MyApp(getFirstInstall: getFirstInstall),
          ),
        ),
      ));
}
