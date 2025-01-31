import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_initicon/flutter_initicon.dart';
import 'package:test_potensial/core/cubit/user_cubit.dart';
import 'package:test_potensial/core/routes/routes_pages.dart';
import 'package:test_potensial/core/shared/positioned/dimensions.dart';
import 'package:test_potensial/core/shared/text_style/text_app_style.dart';
import 'package:test_potensial/core/shared/widget/form_widget.dart';
import 'package:test_potensial/core/shared/widget/loading_widget.dart';
import 'package:test_potensial/core/theme/app_palette.dart';
import 'package:test_potensial/core/utils/extension_utils.dart';
import 'package:test_potensial/features/profile/Widget/box_shadow.dart';
import 'package:test_potensial/features/teacher/home_teacher/presentation/home_teacher_controller.dart';

import 'package:test_potensial/features/teacher/home_teacher/widget/icon_member_widget.dart';

import '../bloc/home_teacher_bloc.dart';

class HomeTeacherScreen extends StatefulWidget {
  const HomeTeacherScreen({super.key});

  @override
  State<HomeTeacherScreen> createState() => _HomeTeacherScreenState();
}

class _HomeTeacherScreenState extends State<HomeTeacherScreen> {
  late HomeTeacherController _controller;
  @override
  void initState() {
    _controller = HomeTeacherController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppPalette.primaryColor,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return Form(
                key: _controller.key,
                child: AlertDialog(
                  title: Row(
                    children: [
                      Text(
                        'Create class',
                        style: TextAppStyle.poppinsMedium.copyWith(fontSize: 16),
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () => Navigator.pop(context),
                        child: const Icon(Icons.close),
                      )
                    ],
                  ),
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text.rich(
                        textAlign: TextAlign.start,
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'Title',
                              style: TextAppStyle.poppinsReguler.copyWith(
                                color: Colors.black,
                              ),
                            ),
                            TextSpan(
                              text: ' *',
                              style: TextAppStyle.poppinsReguler.copyWith(
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                      FormWidget(
                        validatedText: 'Title',
                        hintText: 'Ex: Research Methodology',
                        controller: _controller.waktuController,
                        inputType: TextInputType.text,
                        textStyle: TextAppStyle.poppinsReguler.copyWith(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        'Date',
                        style: TextAppStyle.poppinsReguler,
                      ).paddingOnly(top: 12),
                      FormWidget(
                        validator: (_) => null,
                        validatedText: 'Date',
                        hintText: 'Ex: Tuesday(2.00PM-4.00PM)',
                        controller: _controller.waktuController,
                        inputType: TextInputType.text,
                        textStyle: TextAppStyle.poppinsReguler.copyWith(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (_controller.key.currentState!.validate()) {}
                        },
                        child: Text(
                          'Submit',
                          style: TextAppStyle.poppinsMedium.copyWith(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ).paddingOnly(top: 32)
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Home',
          style: TextAppStyle.poppinsSemiBold.copyWith(fontSize: 20),
        ),
        actions: [
          BlocBuilder<UserCubit, UserState>(
            builder: (context, state) {
              return switch (state) {
                UserLoading() => const Scaffold(body: Loading()),
                UserLoggedIn() => InkWell(
                    onTap: () => Navigator.push(
                      context,
                      Routes.profile(user: state.user),
                    ),
                    child: (state.user.image == null)
                        ? Initicon(text: '${state.user.firstName} ${state.user.lastName}')
                        : CircleAvatar(
                            radius: 25,
                            backgroundImage: NetworkImage(state.user.image ?? ''),
                          ),
                  ).paddingOnly(right: 10),
                _ => const SizedBox()
              };
            },
          ),
        ],
      ),
      body: BlocConsumer<HomeTeacherBloc, HomeTeacherState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          if (state is HomeTeacherInitial) context.read<HomeTeacherBloc>().add(const GetClassEvent());
          return switch (state) {
            HomeTeacherLoading() => const Loading(),
            HomeTeacherLoaded() => InkWell(
                onTap: () => Navigator.pushAndRemoveUntil(
                  context,
                  Routes.kelasTeacher(),
                  (route) => false,
                ),
                child: Container(
                    height: 200,
                    width: Dimensions.screenWidht(context),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [shadow()],
                      color: Colors.white,
                    ),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisSize: MainAxisSize.min,
                            children: state.classes
                                .map(
                                  (value) => Column(
                                    children: [
                                      Container(
                                          height: constraints.maxHeight / 2,
                                          width: constraints.maxWidth,
                                          decoration: BoxDecoration(
                                              borderRadius: const BorderRadius.only(
                                                topLeft: Radius.circular(8),
                                                topRight: Radius.circular(8),
                                              ),
                                              color: value.classColor),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                value.className!,
                                                style: TextAppStyle.poppinsMedium.copyWith(
                                                  fontSize: 16,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              Text(
                                                value.classDescription!,
                                                style: TextAppStyle.poppinsReguler.copyWith(
                                                  fontSize: 12,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              const Spacer(),
                                              Text(
                                                value.classAuthor!,
                                                style: TextAppStyle.poppinsMedium.copyWith(
                                                  fontSize: 12,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ],
                                          ).paddingAll(20)),
                                      value.members?.isNotEmpty ?? true
                                          ? Padding(
                                              padding: EdgeInsets.only(
                                                left: constraints.maxWidth -
                                                    (value.members!.length == 1
                                                        ? 50
                                                        : value.members!.length == 2
                                                            ? 80
                                                            : 100),
                                              ),
                                              child: SizedBox(
                                                height: constraints.maxHeight / 2,
                                                child: InkWell(
                                                  onTap: () {},
                                                  child: Stack(
                                                    clipBehavior: Clip.none,
                                                    children: [
                                                      if (value.members?.isNotEmpty ?? false)
                                                        for (int i = 0; i < value.members!.length; i++)
                                                          if (i < 2 && i >= 0)
                                                            iconMember(
                                                              context: context,
                                                              index: i,
                                                              icon: CircleAvatar(
                                                                radius: 25,
                                                                backgroundImage:
                                                                    NetworkImage(value.members?[i].userProfile ?? ''),
                                                              ),
                                                            )
                                                          else if (i == 2)
                                                            iconMember(
                                                              context: context,
                                                              index: i,
                                                              icon: const Icon(
                                                                Icons.add,
                                                                color: Colors.white,
                                                              ),
                                                            )
                                                    ].reversed.toList(),
                                                  ),
                                                ),
                                              ),
                                            )
                                          : const SizedBox()
                                    ],
                                  ),
                                )
                                .toList());
                      },
                    )).paddingAll(25),
              ),
            HomeTeacherError() => Center(
                child: Text(state.message),
              ),
            _ => const SizedBox()
          };
        },
      ),
    );
  }
}
