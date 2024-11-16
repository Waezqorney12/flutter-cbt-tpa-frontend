import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_initicon/flutter_initicon.dart';
import 'package:test_potensial/core/cubit/user_cubit.dart';
import 'package:test_potensial/core/entities/user_entities.dart';
import 'package:test_potensial/core/shared/positioned/dimensions.dart';
import 'package:test_potensial/core/shared/text_style/text_app_style.dart';
import 'package:test_potensial/core/theme/app_palette.dart';
import 'package:test_potensial/core/utils/map_index_utils.dart';
import 'package:test_potensial/core/utils/regex_utils.dart';
import 'package:test_potensial/features/profile/controller/profile_controller.dart';

import '../../../core/routes/routes_pages.dart';
import '../../../core/utils/notification_dialog_utils.dart';
import '../Widget/box_shadow.dart';
import '../Widget/list_tile_menu_widget.dart';

class ProfileScreen extends StatefulWidget {
  final UserEntities? user;
  const ProfileScreen({super.key, this.user});

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
            child: Column(
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
                          child: (widget.user!.image == null)
                              ? Initicon(text: '${widget.user?.firstName} ${widget.user?.lastName}')
                              : CircleAvatar(
                                  radius: 25,
                                  backgroundImage: NetworkImage(widget.user!.image!),
                                ),
                        ),
                        const SizedBox(width: 15),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${widget.user?.firstName} ${widget.user?.lastName}',
                              style: TextAppStyle.urbanistBold.copyWith(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              '@${nameEmail(widget.user?.email ?? '')}',
                              style: TextAppStyle.urbanistReguler.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        (widget.user!.phone!.isEmpty)
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
                            [
                              () => Navigator.push(context, Routes.profileDetail(widget.user ?? const UserEntities())),
                              // Navigator.pushAndRemoveUntil(
                              //       context,
                              //       Routes.profileDetail(widget.user ?? const UserEntities()),
                              //       (route) => false,
                              //     ),
                              () => Navigator.push(context, Routes.faceId()),
                              () {},
                              () => Navigator.push(context, Routes.twoFactorAuthentication()),
                              () => Navigator.push(context, Routes.history()),
                              () => notificationDialog(
                                    context: context,
                                    onTap: () {
                                      context.read<UserCubit>().removeToken();
                                      Navigator.pop(context);
                                    },
                                    text: 'Anda yakin ingin logout?',
                                  ),
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
          ),
        ),
      ),
    );
  }
}
