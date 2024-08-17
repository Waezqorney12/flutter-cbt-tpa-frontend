import 'package:flutter/material.dart';
import '/features/about%20us/about_us_screen.dart';
import '/features/auth/presentation/create_password_screen.dart';
import '/features/auth/presentation/forgot_password_screen.dart';
import '/features/auth/presentation/otp_screen.dart';
import '/features/bottom_navigator/bottom_navigator_widget.dart';
import '/features/face_id/face_id_screen.dart';
import '/features/home/presentation/home_screen.dart';
import '/features/materi/presentation/materi_screen.dart';
import '/features/onboarding/presentation/onboarding_screen.dart';
import '/features/profile_detail/profile_detail_screen.dart';
import '/features/quiz/quiz_screen.dart';
import '/features/tips%20&%20trick/tips_screen.dart';
import '/features/two_factor_auth/two_factor_auth_screen.dart';

import '../../features/auth/presentation/login_screen.dart';
import '../../features/auth/presentation/register_screen.dart';
import '../../features/quiz_detail/quiz_detail_screen.dart';

class Routes {
  static MaterialPageRoute login() => MaterialPageRoute(builder: (context) => const LoginScreen());
  static MaterialPageRoute regist() => MaterialPageRoute(builder: (context) => const RegisterScreen());
  static MaterialPageRoute home() => MaterialPageRoute(builder: (context) => const HomeScreen());
  static MaterialPageRoute nav() => MaterialPageRoute(builder: (context) => BottomNavigatorWidget());
  static MaterialPageRoute onboarding() => MaterialPageRoute(builder: (context) => const OnBoardingScreen());
  static MaterialPageRoute forgot() => MaterialPageRoute(builder: (context) => const ForgotPasswordScreen());
  static MaterialPageRoute otp({required String userEmail}) => MaterialPageRoute(
        builder: (context) => OtpScreen(userEmail: userEmail),
      );
  static MaterialPageRoute createPassword() => MaterialPageRoute(builder: (context) => const CreatePasswordScreen());
  static MaterialPageRoute profileDetail() => MaterialPageRoute(builder: (context) => const ProfileDetailScreen());
  static MaterialPageRoute twoFactorAuthentication() => MaterialPageRoute(builder: (context) => const TwoFactorAuthScreen());
  static MaterialPageRoute faceId() => MaterialPageRoute(builder: (context) => const FaceIdScreen());

  // Home Menu
  static MaterialPageRoute materi() => MaterialPageRoute(builder: (context) => const MateriScreen());
  static MaterialPageRoute quiz() => MaterialPageRoute(builder: (context) => const QuizScreen());
  static MaterialPageRoute aboutUs() => MaterialPageRoute(builder: (context) => const AboutUsScreen());
  static MaterialPageRoute tipsTrick() => MaterialPageRoute(builder: (context) => const TipsScreen());

  static MaterialPageRoute detailQuiz(String category) =>
      MaterialPageRoute(builder: (context) => QuizDetailScreen(category: category));
}
