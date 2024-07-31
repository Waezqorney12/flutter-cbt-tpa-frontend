import 'package:flutter/material.dart';
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
  @override
  void dispose() {
    ForgotPasswordController.emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
              padding: const EdgeInsets.symmetric(vertical: 17),
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
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  Routes.otp(userEmail: ForgotPasswordController.emailController.text),
                );
              },
              child: Text(
                'SEND VERIFICATION CODE',
                style: TextAppStyle.poppinsMedium.copyWith(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
