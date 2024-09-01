import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
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
    const FlutterSecureStorage secureStorage = FlutterSecureStorage();
    try {
      if (await secureStorage.read(key: 'access_token') != null) {
        sharedPreferences.setString('refresh_token', await secureStorage.read(key: 'access_token') ?? '');
        return true;
      }
      return false;
    } catch (e) {
      rethrow;
    }
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
