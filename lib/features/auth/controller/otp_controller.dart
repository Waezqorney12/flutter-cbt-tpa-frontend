import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_potensial/core/routes/routes_pages.dart';
import 'package:test_potensial/features/auth/bloc/forgot_password_bloc.dart';

class OtpController {
  static TextEditingController firstNumber = TextEditingController();
  static TextEditingController secondNumber = TextEditingController();
  static TextEditingController thirdNumber = TextEditingController();
  static TextEditingController fourthNumber = TextEditingController();

  static void initializeControllers() {
    firstNumber = TextEditingController();
    secondNumber = TextEditingController();
    thirdNumber = TextEditingController();
    fourthNumber = TextEditingController();
  }

  static void disposeControllers() {
    firstNumber.dispose();
    secondNumber.dispose();
    thirdNumber.dispose();
    fourthNumber.dispose();
  }
}
