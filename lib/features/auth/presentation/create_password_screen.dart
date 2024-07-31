import 'package:flutter/material.dart';
import 'package:test_potensial/features/auth/controller/create_password_controller.dart';

import '../../../core/shared/text_style/text_app_style.dart';
import '../../../core/shared/widget/form_widget.dart';
import '../../../core/shared/widget/primary_button.dart';
import '../../../core/theme/app_palette.dart';

class CreatePasswordScreen extends StatefulWidget {
  const CreatePasswordScreen({super.key});

  @override
  State<CreatePasswordScreen> createState() => CreatePasswordScreenState();
}

class CreatePasswordScreenState extends State<CreatePasswordScreen> {
  @override
  void dispose() {
    CreatePasswordController.passwordController.dispose();
    CreatePasswordController.confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Create Password',
              style: TextAppStyle.poppinsSemiBold.copyWith(
                color: AppPalette.loginTextColor,
                fontSize: 24,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 32),
              child: Text(
                'Create your new password to login',
                style: TextAppStyle.poppinsReguler.copyWith(
                  color: Colors.grey[600],
                ),
              ),
            ),
            FormWidget(
              hintText: 'Password',
              textStyle: TextAppStyle.poppinsReguler.copyWith(
                color: AppPalette.loginTextColor,
                fontSize: 15,
              ),
              controller: CreatePasswordController.passwordController,
              obscureText: true,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: FormWidget(
                hintText: 'Confirmation Password',
                textStyle: TextAppStyle.poppinsReguler.copyWith(
                  color: AppPalette.loginTextColor,
                  fontSize: 15,
                ),
                controller: CreatePasswordController.confirmPasswordController,
                obscureText: true,
              ),
            ),
            primaryButton(
              context,
              text: 'CREATE NEW PASSWORD',
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
