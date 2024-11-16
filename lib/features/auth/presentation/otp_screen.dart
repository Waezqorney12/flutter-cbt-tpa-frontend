import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_potensial/features/auth/controller/otp_controller.dart';
import 'package:test_potensial/features/auth/widget/otp_number_widget.dart';
import 'package:test_potensial/core/shared/widget/primary_button.dart';

import '../../../core/routes/routes_pages.dart';
import '../../../core/shared/text_style/text_app_style.dart';
import '../../../core/shared/widget/loading_widget.dart';
import '../../../core/theme/app_palette.dart';
import '../../../core/utils/notification_dialog_utils.dart';
import '../bloc/forgot_password_bloc.dart';

class OtpScreen extends StatefulWidget {
  final String userEmail;
  const OtpScreen({super.key, required this.userEmail});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    OtpController.initializeControllers();
    super.initState();
  }

  @override
  void dispose() {
    OtpController.disposeControllers();
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
            children: [
              Text(
                'Enter Verification Code',
                style: TextAppStyle.poppinsSemiBold.copyWith(
                  color: AppPalette.loginTextColor,
                  fontSize: 24,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: RichText(
                  text: TextSpan(
                      text: 'Enter code that we have sent to your email ',
                      style: TextAppStyle.poppinsReguler.copyWith(
                        color: Colors.grey[600],
                      ),
                      children: [
                        TextSpan(
                          text: widget.userEmail,
                          style: TextAppStyle.poppinsSemiBold.copyWith(
                            color: AppPalette.loginTextColor,
                          ),
                        )
                      ]),
                ),
              ),
              Row(
                children: [
                  otpNumberWidget(context, controller: OtpController.firstNumber),
                  const SizedBox(width: 20),
                  otpNumberWidget(context, controller: OtpController.secondNumber),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: otpNumberWidget(context, controller: OtpController.thirdNumber),
                  ),
                  otpNumberWidget(context, controller: OtpController.fourthNumber),
                ],
              ),
              BlocConsumer<ForgotPasswordBloc, ForgotPasswordState>(
                listener: (context, state) {
                  if (state is VerifyCodeSuccess)
                    notificationDialog(
                      context: context,
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pushAndRemoveUntil(
                          context,
                          Routes.login(),
                          (route) => false,
                        );
                      },
                      text: state.message,
                      isOption: false,
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
                      return Padding(
                        padding: const EdgeInsets.only(top: 40, bottom: 24),
                        child: ElevatedButton(
                            onPressed: () {},
                            child: const SizedBox(
                              height: 20,
                              width: 20,
                              child: Loading(),
                            )),
                      );
                    default:
                      return Padding(
                        padding: const EdgeInsets.only(top: 40, bottom: 24),
                        child: primaryButton(
                          context,
                          text: 'VERIFY',
                          onTap: () {
                            if (formKey.currentState!.validate()) {
                              context.read<ForgotPasswordBloc>().add(VerifyOtpCodeEvent(
                                    otpCode: OtpController.firstNumber.text.trim() +
                                        OtpController.secondNumber.text.trim() +
                                        OtpController.thirdNumber.text.trim() +
                                        OtpController.fourthNumber.text.trim(),
                                  ));
                            } else {
                              notificationDialog(
                                context: context,
                                onTap: () => Navigator.pop(context),
                                text: 'Please fill your code ',
                                isOption: false,
                              );
                            }
                          },
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
