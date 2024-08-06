import 'package:flutter/material.dart';
import 'package:flutter_initicon/flutter_initicon.dart';
import 'package:test_potensial/core/shared/text_style/text_app_style.dart';
import 'package:test_potensial/core/shared/widget/form_widget.dart';
import 'package:test_potensial/core/shared/widget/phone_form_field_widget.dart';
import 'package:test_potensial/features/profile/Widget/box_shadow.dart';
import 'package:test_potensial/features/profile_detail/profile_detail_controller.dart';

class ProfileDetailScreen extends StatefulWidget {
  const ProfileDetailScreen({super.key});

  @override
  State<ProfileDetailScreen> createState() => _ProfileDetailScreenState();
}

class _ProfileDetailScreenState extends State<ProfileDetailScreen> {
  final _controller = ProfileDetailController();

  @override
  void dispose() {
    _controller.emailController.dispose();
    _controller.nameController.dispose();
    _controller.phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          'My Account',
          style: TextAppStyle.urbanistSemiBold.copyWith(fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        child: Column(
          children: [
            const SizedBox(
              height: 72,
              width: 72,
              child: Initicon(text: 'test'),
            ),
            const SizedBox(height: 25),
            Container(
              decoration: BoxDecoration(boxShadow: [shadow()]),
              child: FormWidget(
                hintText: "What's your name?",
                inputType: TextInputType.text,
                textStyle: TextAppStyle.interReguler,
                controller: _controller.nameController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [shadow()],
                ),
                child: FormWidget(
                  hintText: "What's your email?",
                  inputType: TextInputType.emailAddress,
                  textStyle: TextAppStyle.interReguler,
                  controller: _controller.emailController,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                boxShadow: [shadow()],
              ),
              child: PhoneFormField(
                controller: _controller.phoneController,
                onCountryChanged: (country) {
                  // TODO: Implement phone number, country code, and country name
                },
              ),
            ),
            const SizedBox(height: 35),
            ElevatedButton(
              onPressed: () {},
              child: Text(
                'Update Profile',
                style: TextAppStyle.poppinsMedium.copyWith(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
