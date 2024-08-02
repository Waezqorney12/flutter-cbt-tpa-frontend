import 'package:flutter/material.dart';
import 'package:test_potensial/features/about%20us/about_us_screen.dart';
import 'package:test_potensial/features/auth/presentation/create_password_screen.dart';
import 'package:test_potensial/features/auth/presentation/forgot_password_screen.dart';
import 'package:test_potensial/features/auth/presentation/otp_screen.dart';
import 'package:test_potensial/features/bottom_navigator/bottom_navigator_widget.dart';
import 'package:test_potensial/features/home/presentation/home_screen.dart';
import 'package:test_potensial/features/materi/presentation/materi_screen.dart';
import 'package:test_potensial/features/materi_detail/materi_detail_screen.dart';
import 'package:test_potensial/features/quiz/quiz_screen.dart';
import 'package:test_potensial/features/tips%20&%20trick/tips_screen.dart';

import '../../features/auth/presentation/login_screen.dart';
import '../../features/auth/presentation/register_screen.dart';

class Routes {
  static MaterialPageRoute login() => MaterialPageRoute(builder: (context) => const LoginScreen());
  static MaterialPageRoute regist() => MaterialPageRoute(builder: (context) => const RegisterScreen());
  static MaterialPageRoute home() => MaterialPageRoute(builder: (context) => const HomeScreen());
  static MaterialPageRoute nav() => MaterialPageRoute(builder: (context) => BottomNavigatorWidget());
  static MaterialPageRoute forgot() => MaterialPageRoute(builder: (context) => const ForgotPasswordScreen());
  static MaterialPageRoute otp({required String userEmail}) => MaterialPageRoute(
        builder: (context) => OtpScreen(userEmail: userEmail),
      );
  static MaterialPageRoute createPassword() => MaterialPageRoute(builder: (context) => const CreatePasswordScreen());

  // Home Menu
  static MaterialPageRoute materi() => MaterialPageRoute(builder: (context) => const MateriScreen());
  static MaterialPageRoute quiz() => MaterialPageRoute(builder: (context) => const QuizScreen());
  static MaterialPageRoute aboutUs() => MaterialPageRoute(builder: (context) => const AboutUsScreen());
  static MaterialPageRoute tipsTrick() => MaterialPageRoute(builder: (context) => const TipsScreen());

  static MaterialPageRoute materiDetail() => MaterialPageRoute(builder: (context) => const MateriDetailScreen());
}
