import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_potensial/core/shared/widget/loading_widget.dart';
import 'package:test_potensial/core/utils/show_snackbar_utils.dart';
import 'package:test_potensial/features/auth/controller/login_controller.dart';
import 'package:test_potensial/features/auth/widget/option_auth_widget.dart';
import 'package:test_potensial/features/auth/widget/or_divider_widget.dart';
import 'package:test_potensial/features/auth/widget/third_party_button.dart';
import 'package:test_potensial/core/routes/routes_pages.dart';
import 'package:test_potensial/core/shared/text_style/text_app_style.dart';
import 'package:test_potensial/core/shared/widget/form_widget.dart';
import 'package:test_potensial/core/theme/app_palette.dart';

import '../bloc/auth_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();

  late final LoginController _controller;

  @override
  void initState() {
    _controller = LoginController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.emailController.dispose();
    _controller.passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final widht = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthError) showSnackBar(context, state.message);
          },
          builder: (context, state) {
            if (state is AuthLoading) return const Loading();
            return Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        'Log in',
                        style: TextAppStyle.poppinsMedium.copyWith(
                          color: AppPalette.boardingTextColor,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    const SizedBox(height: 34),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 17),
                      child: FormWidget(
                        hintText: 'Email Address',
                        textStyle: TextAppStyle.poppinsReguler.copyWith(
                          color: AppPalette.loginTextColor,
                          fontSize: 15,
                        ),
                        controller: _controller.emailController,
                        inputType: TextInputType.emailAddress,
                      ),
                    ),
                    FormWidget(
                      hintText: 'Password',
                      textStyle: TextAppStyle.poppinsReguler.copyWith(
                        color: AppPalette.loginTextColor,
                        fontSize: 15,
                      ),
                      controller: _controller.passwordController,
                      obscureText: true,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 14, bottom: 42),
                      child: InkWell(
                        onTap: () => Navigator.push(context, Routes.forgot()),
                        child: Text(
                          'Forgot Password',
                          style: TextAppStyle.poppinsMedium.copyWith(
                            fontSize: 15,
                            color: AppPalette.primaryColor,
                          ),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          _controller.signIn(context);
                          Navigator.pushReplacement(context, Routes.nav());
                        }
                      },
                      child: Text(
                        'LOG IN',
                        style: TextAppStyle.poppinsMedium.copyWith(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    optionAuthWidget(
                      context,
                      firstText: "Don't have account? ",
                      secondText: 'Register here',
                      onTap: () => Navigator.push(context, Routes.regist()),
                    ),
                    orDivederWidget(context, widht: widht),
                    thirdPartyButton(
                      context,
                      widht: widht,
                      image: 'assets/icon/google.svg',
                      text: 'Sign In with Google',
                      onPressed: () {},
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: thirdPartyButton(
                        context,
                        widht: widht,
                        image: 'assets/icon/apple.svg',
                        text: 'Sign In with Apple',
                        onPressed: () {},
                      ),
                    ),
                    thirdPartyButton(
                      context,
                      widht: widht,
                      image: 'assets/icon/facebook.svg',
                      text: 'Sign In with Facebook',
                      onPressed: () {},
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
