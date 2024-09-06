import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_potensial/core/shared/widget/loading_widget.dart';
import 'package:test_potensial/core/utils/notification_dialog_utils.dart';
import 'package:test_potensial/core/utils/show_snackbar_utils.dart';
import 'package:test_potensial/features/auth/bloc/auth_bloc.dart';
import 'package:test_potensial/features/auth/controller/register_controller.dart';
import 'package:test_potensial/features/auth/widget/option_auth_widget.dart';
import 'package:test_potensial/features/auth/widget/or_divider_widget.dart';
import 'package:test_potensial/core/routes/routes_pages.dart';

import '../../../core/shared/text_style/text_app_style.dart';
import '../../../core/shared/widget/form_widget.dart';
import '../../../core/theme/app_palette.dart';
import '../widget/third_party_button.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final key = GlobalKey<FormState>();
  late RegisterController _controller;

  @override
  void initState() {
    _controller = RegisterController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.emailController.dispose();
    _controller.usernameController.dispose();
    _controller.passwordController.dispose();
    _controller.confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final widht = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is AuthRegister)
                  notificationDialog(
                    context: context,
                    title: 'Success',
                    isOption: false,
                    onTap: () => Navigator.pushAndRemoveUntil(
                      context,
                      Routes.login(),
                      (route) => false,
                    ),
                    text: state.message,
                  );

                if (state is AuthError) showSnackBar(context, state.message);
              },
              builder: (context, state) {
                if (state is AuthLoading) return const Loading();
                return Form(
                  key: key,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      children: [
                        Text(
                          'Register',
                          style: TextAppStyle.poppinsMedium.copyWith(
                            color: AppPalette.boardingTextColor,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 34),
                        FormWidget(
                          hintText: 'Email Address',
                          textStyle: TextAppStyle.poppinsReguler.copyWith(
                            color: AppPalette.loginTextColor,
                            fontSize: 15,
                          ),
                          controller: _controller.emailController,
                          inputType: TextInputType.emailAddress,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 17),
                          child: FormWidget(
                            hintText: 'Username',
                            textStyle: TextAppStyle.poppinsReguler.copyWith(
                              color: AppPalette.loginTextColor,
                              fontSize: 15,
                            ),
                            controller: _controller.usernameController,
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
                          padding: const EdgeInsets.only(top: 17, bottom: 25),
                          child: FormWidget(
                            hintText: 'Confirmation Password',
                            textStyle: TextAppStyle.poppinsReguler.copyWith(
                              color: AppPalette.loginTextColor,
                              fontSize: 15,
                            ),
                            controller: _controller.confirmPasswordController,
                            obscureText: true,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (key.currentState!.validate()) {
                              if (_controller.passwordController.text.length < 8) {
                                showSnackBar(context, 'Password must be at least 8 characters');
                              } else if (_controller.passwordController.text == _controller.confirmPasswordController.text) {
                                _controller.signUp(context);
                              } else {
                                showSnackBar(context, 'Password not match');
                              }
                            }
                          },
                          child: Text(
                            'REGISTER',
                            style: TextAppStyle.poppinsMedium.copyWith(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        optionAuthWidget(
                          context,
                          firstText: 'Already have account? ',
                          secondText: 'Sign in',
                          onTap: () => Navigator.push(context, Routes.login()),
                        ),
                        orDivederWidget(context, widht: widht),
                        thirdPartyButton(
                          context,
                          widht: widht,
                          image: 'assets/icon/google.svg',
                          text: 'Register with Google',
                          onPressed: () {},
                        ),
                        Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: thirdPartyButton(
                              context,
                              widht: widht,
                              image: 'assets/icon/facebook.svg',
                              text: 'Register with Facebook',
                              onPressed: () {},
                            )),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
