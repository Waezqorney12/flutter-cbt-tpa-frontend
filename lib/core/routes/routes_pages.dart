import 'package:flutter/material.dart';
import 'package:test_potensial/core/entities/user_entities.dart';
import 'package:test_potensial/features/profile/presentation/profile_screen.dart';
import 'package:test_potensial/features/student/history_nilai/presentation/history_nilai_screen.dart';
import 'package:test_potensial/features/student/quiz_detail/domain/usecase/quiz_usecase.dart';
import 'package:test_potensial/features/student/quiz_nilai/presentation/quiz_nilai_screen.dart';
import 'package:test_potensial/features/teacher/home_teacher/presentation/home_teacher_screen.dart';
import 'package:test_potensial/features/teacher/kelas_teacher/presentation/kelas_teacher_screen.dart';
import 'package:test_potensial/features/teacher/materi_teacher_form/materi_teacher_form_screen.dart';
import 'package:test_potensial/features/teacher/quiz_teacher_detail_form/presentation/quiz_detail_form_question/quiz_teacher_detail_form_question_screen.dart';
import 'package:test_potensial/features/teacher/quiz_teacher_detail_form/presentation/quiz_detail_form/quiz_teacher_detail_form_screen.dart';
import 'package:test_potensial/features/teacher/quiz_teacher_form/quiz_teacher_form_screen.dart';
import '/features/about%20us/about_us_screen.dart';
import '/features/auth/presentation/create_password_screen.dart';
import '/features/auth/presentation/forgot_password_screen.dart';
import '/features/auth/presentation/otp_screen.dart';
import '/features/bottom_navigator/bottom_navigator_widget.dart';
import '/features/face_id/face_id_screen.dart';
import '../../features/student/home_student/presentation/home_screen.dart';
import '../../features/student/materi/presentation/materi_screen.dart';
import '/features/onboarding/presentation/onboarding_screen.dart';
import '/features/profile_detail/profile_detail_screen.dart';
import '../../features/student/quiz/quiz_screen.dart';

import '../../features/auth/presentation/login_screen.dart';
import '../../features/auth/presentation/register_screen.dart';
import '../../features/student/quiz_detail/presentation/screen/quiz_detail_screen.dart';

class Routes {
  static MaterialPageRoute login() => MaterialPageRoute(builder: (context) => const LoginScreen());
  static MaterialPageRoute regist() => MaterialPageRoute(builder: (context) => const RegisterScreen());
  static MaterialPageRoute home() => MaterialPageRoute(builder: (context) => const HomeScreen());
  static MaterialPageRoute homeTeacher() => MaterialPageRoute(builder: (context) => const HomeTeacherScreen());
  static MaterialPageRoute nav() => MaterialPageRoute(builder: (context) => BottomNavigatorWidget());
  static MaterialPageRoute onboarding() => MaterialPageRoute(builder: (context) => const OnBoardingScreen());
  static MaterialPageRoute forgot() => MaterialPageRoute(builder: (context) => const ForgotPasswordScreen());
  static MaterialPageRoute otp({required String userEmail}) => MaterialPageRoute(
        builder: (context) => OtpScreen(userEmail: userEmail),
      );
  static MaterialPageRoute createPassword() => MaterialPageRoute(builder: (context) => const CreatePasswordScreen());
  static MaterialPageRoute profile({UserEntities? user}) => MaterialPageRoute(
      builder: (context) => ProfileScreen(
            user: user,
          ));
  static MaterialPageRoute profileDetail(UserEntities user) =>
      MaterialPageRoute(builder: (context) => ProfileDetailScreen(user: user));
  static MaterialPageRoute faceId() => MaterialPageRoute(builder: (context) => const FaceIdScreen());

  // Home Menu
  static MaterialPageRoute materi() => MaterialPageRoute(builder: (context) => const MateriScreen());
  static MaterialPageRoute quiz() => MaterialPageRoute(builder: (context) => const QuizScreen());
  static MaterialPageRoute aboutUs() => MaterialPageRoute(builder: (context) => const AboutUsScreen());
  static MaterialPageRoute history() => MaterialPageRoute(builder: (context) => const HistoryNilaiScreen());

  static MaterialPageRoute quizNilai() => MaterialPageRoute(builder: (context) => const QuizNilaiScreen());

  static MaterialPageRoute detailQuiz({required String title, required GetDetailQuizParams params}) => MaterialPageRoute(
      builder: (context) => QuizDetailScreen(
            title: title,
            params: params,
          ));

  static MaterialPageRoute kelasTeacher() => MaterialPageRoute(builder: (context) => const KelasTeacherScreen());
  static MaterialPageRoute materiForm() => MaterialPageRoute(builder: (context) => const MateriTeacherFormScreen());
  static MaterialPageRoute quizForm() => MaterialPageRoute(builder: (context) => const QuizTeacherFormScreen());
  static MaterialPageRoute quizDetailForm({required String type, required String category}) => MaterialPageRoute(
      builder: (context) => QuizTeacherDetailFormScreen(
            questionCategory: category,
            questionType: type,
          ));
  static MaterialPageRoute questionDetailForm() =>
      MaterialPageRoute(builder: (context) => const QuizTeacherDetailFormQuestionScreen());
}
