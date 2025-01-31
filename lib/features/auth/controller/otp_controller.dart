import 'package:flutter/material.dart';

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
