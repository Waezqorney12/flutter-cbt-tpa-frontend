import 'package:flutter/material.dart';
import 'package:test_potensial/core/routes/routes_pages.dart';

class OtpController {
  static TextEditingController firstNumber = TextEditingController();
  static TextEditingController secondNumber = TextEditingController();
  static TextEditingController thirdNumber = TextEditingController();
  static TextEditingController fourthNumber = TextEditingController();

  static void checkOtp(BuildContext context) {
    if (firstNumber.text.isNotEmpty &&
        secondNumber.text.isNotEmpty &&
        thirdNumber.text.isNotEmpty &&
        fourthNumber.text.isNotEmpty) {
      Navigator.push(context, Routes.createPassword());
    }
  }
}
