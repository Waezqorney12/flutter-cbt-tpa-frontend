import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_potensial/core/shared/widget/loading_widget.dart';
import 'package:test_potensial/core/utils/log.dart';
import 'package:test_potensial/core/utils/notification_dialog_utils.dart';
import 'package:test_potensial/features/auth/bloc/forgot_password_bloc.dart';
import 'package:test_potensial/features/auth/controller/forgot_password_controller.dart';
import 'package:test_potensial/core/routes/routes_pages.dart';
import 'package:test_potensial/core/shared/text_style/text_app_style.dart';
import 'package:test_potensial/core/shared/widget/form_widget.dart';
import 'package:test_potensial/core/theme/app_palette.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    ForgotPasswordController.initializeControllers();
    super.initState();
  }

  @override
  void dispose() {
    ForgotPasswordController.disposeControllers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Forgot Your Password?',
                style: TextAppStyle.poppinsSemiBold.copyWith(
                  color: AppPalette.loginTextColor,
                  fontSize: 24,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  'No worries, you just need to type your email address or username and we will send the verification code.',
                  style: TextAppStyle.poppinsReguler.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: FormWidget(
                  hintText: 'Email Address',
                  textStyle: TextAppStyle.poppinsReguler.copyWith(
                    color: AppPalette.loginTextColor,
                    fontSize: 15,
                  ),
                  controller: ForgotPasswordController.emailController,
                  inputType: TextInputType.emailAddress,
                ),
              ),
              BlocConsumer<ForgotPasswordBloc, ForgotPasswordState>(
                listener: (context, state) {
                  if (state is SendEmailSuccess)
                    Navigator.push(
                      context,
                      Routes.otp(userEmail: ForgotPasswordController.emailController.text),
                    );
                  if (state is ForgotPasswordError) {
                    notificationDialog(
                      context: context,
                      onTap: () => Navigator.pop(context),
                      text: state.message,
                      isOption: false,
                    );
                  }
                },
                builder: (context, state) {
                  switch (state) {
                    case ForgotPasswordLoading():
                      return ElevatedButton(
                          onPressed: () {},
                          child: const SizedBox(
                            height: 20,
                            width: 20,
                            child: Loading(),
                          ));
                    default:
                      return ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            Log.loggerInformation('Forgot Password State: $state');
                            context.read<ForgotPasswordBloc>().add(SendEmailEvent(
                                  email: ForgotPasswordController.emailController.text.trim(),
                                ));
                            Log.loggerInformation('Forgot Password State2: $state');
                          } else {
                            notificationDialog(
                              context: context,
                              onTap: () => Navigator.pop(context),
                              text: 'Email address cannot be empty',
                              isOption: false,
                            );
                          }
                        },
                        child: Text(
                          'SEND VERIFICATION CODE',
                          style: TextAppStyle.poppinsMedium.copyWith(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
