import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_potensial/features/auth/bloc/auth_bloc.dart';

class LoginController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void signIn(BuildContext context) {
    context.read<AuthBloc>().add(
          LoginEvent(
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
          ),
        );
  }
}
