import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_initicon/flutter_initicon.dart';
import 'package:test_potensial/core/cubit/user_cubit.dart';
import 'package:test_potensial/core/shared/positioned/dimensions.dart';
import 'package:test_potensial/core/shared/text_style/text_app_style.dart';
import 'package:test_potensial/core/theme/app_palette.dart';
import 'package:test_potensial/core/utils/map_index_utils.dart';
import 'package:test_potensial/core/utils/regex_utils.dart';
import 'package:test_potensial/features/profile/controller/profile_controller.dart';

import '../../../core/routes/routes_pages.dart';
import '../../../core/shared/widget/loading_widget.dart';
import '../Widget/box_shadow.dart';
import '../Widget/list_tile_menu_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late final ProfileController _controller;

  @override
  void initState() {
    _controller = ProfileController();
    Future.microtask(() async {
      _controller.isSwitch = await _controller.getBiometric();
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: BlocConsumer<UserCubit, UserState>(
              listener: (context, state) {
                if (state is UserLoggeoOut || state is UserError) Navigator.pushReplacement(context, Routes.login());
              },
              builder: (context, state) {
                return switch (state) {
                  UserLoading() => const Loading(),
                  UserLoggedIn() => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 78,
                          width: Dimensions.screenWidht(context),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: AppPalette.primaryColor,
                            boxShadow: [shadow()],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              children: [
                                SizedBox(
                                  height: 49,
                                  width: 49,
                                  child: Initicon(text: "${state.user.name}"),
                                ),
                                const SizedBox(width: 15),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${state.user.name}',
                                      style: TextAppStyle.urbanistBold.copyWith(
                                        color: Colors.white,
                                        fontSize: 14,
                                      ),
                                    ),
                                    Text(
                                      '@${nameEmail(state.user.email!)}',
                                      style: TextAppStyle.urbanistReguler.copyWith(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                (state.user.phone!.isEmpty)
                                    ? Container(
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Padding(
                                          padding: EdgeInsets.all(8),
                                          child: Icon(
                                            Icons.warning_amber_rounded,
                                            color: Colors.red,
                                          ),
                                        ),
                                      )
                                    : const SizedBox()
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          width: Dimensions.screenWidht(context),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [shadow()],
                          ),
                          child: Column(
                            children: _controller.menu.mapIndexed<Widget, MenuEntities>(
                              funct: (index, value) {
                                return menu(
                                  index,
                                  value,
                                  trailingWidget: Switch(
                                    activeColor: AppPalette.primaryColor,
                                    thumbColor: WidgetStateProperty.all(Colors.white),
                                    trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
                                    value: _controller.isSwitch,
                                    onChanged: (value) {
                                      setState(() {
                                        _controller.isSwitch = value;
                                        if (_controller.isSwitch) {
                                          _controller.saveBiometric(value);
                                        } else {
                                          _controller.removeBiometric();
                                        }
                                      });
                                    },
                                  ),
                                  onTap: () async {
                                    // [index]() -> for call the function at specific index that match with the menu
                                    [
                                      () => Navigator.push(context, Routes.profileDetail(state.user)),
                                      () => Navigator.push(context, Routes.faceId()),
                                      () {},
                                      () => Navigator.push(context, Routes.twoFactorAuthentication()),
                                      () => Navigator.push(context, Routes.history()),
                                      () => context.read<UserCubit>().removeToken(),
                                    ][index]();
                                  },
                                );
                              },
                            ).toList(),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Text(
                            'More',
                            style: TextAppStyle.poppinsSemiBold.copyWith(
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Container(
                            width: Dimensions.screenWidht(context),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [shadow()],
                            ),
                            child: Column(
                              children: _controller.moreMenu
                                  .mapIndexed<Widget, MenuEntities>(
                                    funct: (index, value) => menu(index, value),
                                  )
                                  .toList(),
                            )),
                      ],
                    ),
                  _ => const SizedBox()
                };
              },
            ),
          ),
        ),
      ),
    );
  }
}
