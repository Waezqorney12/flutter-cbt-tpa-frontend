import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_potensial/core/cubit/user_cubit.dart';
import 'package:test_potensial/core/shared/widget/loading_widget.dart';
import 'package:test_potensial/core/utils/extension_utils.dart';
import 'package:test_potensial/core/utils/log.dart';
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

    Future.microtask(() async {
      final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      if (sharedPreferences.getBool('isOnBoarding') ?? false) {
        _controller.isSwitch = await _controller.checkBiometric();
        setState(() {});
      }
    });
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
            Log.loggerWarning("Login AuthBloc State: $state");

            if (state is AuthLogin) {
              context.read<UserCubit>().getUser();
              context.read<UserCubit>().stream.listen(
                (userState) {
                  if (userState is UserLoggedIn) {
                    final userRole = userState.user.roles ?? 'Undefined';
                    switch (userRole) {
                      case 'USER':
                        Navigator.pushAndRemoveUntil(
                          context,
                          Routes.nav(),
                          (route) => false,
                        );
                      case 'STAFF':
                        Navigator.pushAndRemoveUntil(
                          context,
                          Routes.homeTeacher(),
                          (route) => false,
                        );
                      default:
                        Navigator.pushAndRemoveUntil(
                          context,
                          Routes.login(),
                          (route) => false,
                        );
                    }
                  }
                },
              );
            }
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Log in',
                      style: TextAppStyle.poppinsBold.copyWith(
                        color: AppPalette.boardingTextColor,
                        fontSize: 24,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5, bottom: 15),
                      child: Text(
                        'Welcome to quiz application, please login by fill the existing account to continue',
                        style: TextAppStyle.poppinsReguler.copyWith(
                          color: AppPalette.boardingTextColor.withOpacity(.5),
                          fontSize: 12,
                        ),
                      ),
                    ),
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
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
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
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) _controller.signIn(context);
                            },
                            child: Text(
                              'LOG IN',
                              style: TextAppStyle.poppinsMedium.copyWith(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: AppPalette.primaryColor,
                          ),
                          child: InkWell(
                            onTap: () {
                              if (_controller.isSwitch) {
                                _controller.authenticate().then((value) {
                                  if (value) {
                                    _controller.useFingerPrint().then((_) {
                                      context.read<UserCubit>().stream;
                                    });
                                  }
                                });
                              } else {
                                showSnackBar(context, 'Please enable biometric first');
                              }
                            },
                            child: const Icon(
                              Icons.fingerprint,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        ).paddingOnly(left: 10),
                      ],
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
