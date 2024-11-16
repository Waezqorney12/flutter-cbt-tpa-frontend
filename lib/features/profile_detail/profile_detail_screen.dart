import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_initicon/flutter_initicon.dart';
import 'package:test_potensial/core/entities/user_entities.dart';
import 'package:test_potensial/core/shared/text_style/text_app_style.dart';
import 'package:test_potensial/core/shared/widget/form_widget.dart';
import 'package:test_potensial/core/shared/widget/phone_form_field_widget.dart';
import 'package:test_potensial/core/utils/extension_utils.dart';
import 'package:test_potensial/core/utils/log.dart';
import 'package:test_potensial/features/bottom_navigator/bottom_navigator_widget.dart';
import 'package:test_potensial/features/profile/Widget/box_shadow.dart';
import 'package:test_potensial/features/profile_detail/controller/profile_detail_controller.dart';

import '../../core/cubit/user_cubit.dart';
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
    Log.loggerInformation('User: ${widget.user.image}');
    _controller.emailController.text = widget.user.email ?? '';
    _controller.firstNameController.text = widget.user.firstName ?? '';
    _controller.lastNameController.text = widget.user.lastName ?? '';
    _controller.phoneController.text = widget.user.phone ?? '';
    super.initState();
  }

  @override
  void dispose() {
    _controller.emailController.dispose();
    _controller.firstNameController.dispose();
    _controller.lastNameController.dispose();
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
        child: BlocListener<ProfileDetailCubit, ProfileDetailState>(
          listener: (context, state) {
            if (state is ProfileDetailSuccess) {
              context.read<UserCubit>().getUser();
              SchedulerBinding.instance.addPostFrameCallback((_) {
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                }
              });
            }
          },
          child: Column(
            children: [
              InkWell(
                onTap: () async => await _controller.changeImageProfile().then((_) {
                  setState(() {});
                }),
                child: _controller.image != null
                    ? FileImage(_controller.image!).imageProviderCircleAvatar(radius: 35)
                    : widget.user.image == null
                        ? Initicon(text: '${widget.user.firstName} ${widget.user.lastName}').sized()
                        : NetworkImage(widget.user.image!).imageProviderCircleAvatar(radius: 35),
              ),
              Container(
                decoration: BoxDecoration(boxShadow: [shadow()]),
                child: FormWidget(
                  hintText: "What's your first name?",
                  inputType: TextInputType.text,
                  textStyle: TextAppStyle.interReguler,
                  controller: _controller.firstNameController,
                ),
              ).paddingSymmetric(vertical: 25),
              Container(
                decoration: BoxDecoration(boxShadow: [shadow()]),
                child: FormWidget(
                  hintText: "What's your last name?",
                  inputType: TextInputType.text,
                  textStyle: TextAppStyle.interReguler,
                  controller: _controller.lastNameController,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  boxShadow: [shadow()],
                ),
                child: FormWidget(
                  hintText: "What's your email?",
                  inputType: TextInputType.emailAddress,
                  textStyle: TextAppStyle.interReguler,
                  controller: _controller.emailController,
                ),
              ).paddingSymmetric(vertical: 20),
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
                        firstName: _controller.firstNameController.text,
                        lastName: _controller.lastNameController.text,
                        phone: _controller.phoneController.text,
                        image: _controller.image,
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
      ),
    );
  }
}
