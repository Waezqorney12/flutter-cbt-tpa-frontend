import 'package:flutter/material.dart';
import 'package:test_potensial/features/auth/controller/otp_controller.dart';
import 'package:test_potensial/features/auth/widget/otp_number_widget.dart';
import 'package:test_potensial/core/shared/widget/primary_button.dart';

import '../../../core/shared/text_style/text_app_style.dart';
import '../../../core/theme/app_palette.dart';

class OtpScreen extends StatefulWidget {
  final String userEmail;
  const OtpScreen({super.key, required this.userEmail});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  @override
  void dispose() {
    OtpController.firstNumber.dispose();
    OtpController.secondNumber.dispose();
    OtpController.thirdNumber.dispose();
    OtpController.fourthNumber.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final widht = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
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
            Padding(
              padding: const EdgeInsets.only(top: 40, bottom: 24),
              child: primaryButton(
                context,
                text: 'VERIFY',
                onTap: () {
                  OtpController.checkOtp(context);
                },
              ),
            ),
            InkWell(
              onTap: () {},
              child: Container(
                height: 64,
                width: widht,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey),
                ),
                child: Center(
                  child: Text(
                    'RESEND CODE',
                    style: TextAppStyle.poppinsSemiBold.copyWith(
                      fontSize: 16,
                      color: AppPalette.primaryColor,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
