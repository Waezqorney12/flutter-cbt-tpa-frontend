import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_potensial/core/utils/log.dart';
import 'package:test_potensial/features/auth/bloc/auth_bloc.dart';

class LoginController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final LocalAuthentication auth = LocalAuthentication();

  bool isSwitch = false;

  Future<bool> authenticate() async {
    bool authenticated = false;
    try {
      authenticated = await auth.authenticate(
        localizedReason: 'Please authenticate to access your account',
        options: const AuthenticationOptions(
          biometricOnly: true,
        ),
      );
    } catch (e) {
      Log.loggerFatal('Error: $e');
      rethrow;
    }
    return authenticated;
  }

  Future<bool> checkBiometric() async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool('isSwitch') ?? false;
  }

  void signIn(BuildContext context) {
    context.read<AuthBloc>().add(
          LoginEvent(
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
          ),
        );
  }
}
