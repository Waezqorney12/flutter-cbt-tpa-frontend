import 'package:flutter/material.dart';

class ForgotPasswordController {
  static TextEditingController emailController = TextEditingController();

  static void disposeControllers() {
    emailController.dispose();
  }

  static void initializeControllers() {
    emailController = TextEditingController();
  }
}
