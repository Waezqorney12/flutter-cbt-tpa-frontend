import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_potensial/features/auth/bloc/auth_bloc.dart';

class RegisterController {
  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  void signUp(BuildContext context) {
    context.read<AuthBloc>().add(
          RegisterEvent(
            name: usernameController.text.trim(),
            email: emailController.text.trim(),
            password: confirmPasswordController.text.trim(),
          ),
        );
  }
}
