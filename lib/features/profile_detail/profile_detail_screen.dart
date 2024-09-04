import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_initicon/flutter_initicon.dart';
import 'package:test_potensial/core/entities/user_entities.dart';
import 'package:test_potensial/core/shared/text_style/text_app_style.dart';
import 'package:test_potensial/core/shared/widget/form_widget.dart';
import 'package:test_potensial/core/shared/widget/phone_form_field_widget.dart';
import 'package:test_potensial/features/profile/Widget/box_shadow.dart';
import 'package:test_potensial/features/profile_detail/controller/profile_detail_controller.dart';

import 'cubit/profile_detail_cubit.dart';

class ProfileDetailScreen extends StatefulWidget {
  final UserEntities user;
  const ProfileDetailScreen({super.key, required this.user});

  @override
  State<ProfileDetailScreen> createState() => _ProfileDetailScreenState();
}

class _ProfileDetailScreenState extends State<ProfileDetailScreen> {
  final _controller = ProfileDetailController();

  @override
  void initState() {
    _controller.emailController.text = widget.user.email ?? '';
    _controller.nameController.text = widget.user.name ?? '';
    _controller.phoneController.text = widget.user.phone ?? '';
    super.initState();
  }

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
              onPressed: () {
                context.read<ProfileDetailCubit>().changeProfile(
                      email: _controller.emailController.text,
                      name: _controller.nameController.text,
                      phone: _controller.phoneController.text,
                    );
              },
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
