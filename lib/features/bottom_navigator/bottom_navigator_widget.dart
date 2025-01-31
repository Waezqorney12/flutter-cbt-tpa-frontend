// ignore_for_file: must_be_immutable, curly_braces_in_flow_control_structures

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_potensial/core/cubit/user_cubit.dart';
import 'package:test_potensial/core/shared/text_style/text_app_style.dart';
import 'package:test_potensial/core/theme/app_palette.dart';
import 'package:test_potensial/core/utils/notification_dialog_utils.dart';
import 'package:test_potensial/features/student/home_student/presentation/home_screen.dart';
import 'package:test_potensial/features/student/materi/presentation/materi_screen.dart';
import 'package:test_potensial/features/profile/presentation/profile_screen.dart';

import '../../core/provider/navigator_provider.dart';
import '../../core/shared/widget/loading_widget.dart';
import '../student/quiz/quiz_screen.dart';

class BottomNavigatorWidget extends StatelessWidget {
  final int index;
  BottomNavigatorWidget({super.key, this.index = 0}) {
    currentIndex.value = index;
  }

  ValueNotifier<int> currentIndex = ValueNotifier<int>(0);
  ValueNotifier<bool> isFirstValue = ValueNotifier<bool>(true);

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (isFirstValue.value == false)
          isFirstValue.value = true;
        else {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            notificationDialog(
              context: context,
              onTap: () => exit(0),
              text: 'Apakah anda yakin ingin keluar?',
            );
          });
        }
      },
      child: NavigatorProvider(
        currentIndex: currentIndex,
        isFirst: isFirstValue,
        child: ValueListenableBuilder(
            valueListenable: isFirstValue,
            builder: (context, isFirst, child) {
              return ValueListenableBuilder(
                valueListenable: currentIndex,
                builder: (context, index, child) {
                  return BlocBuilder<UserCubit, UserState>(
                    builder: (context, state) {
                      if (state is UserInitial) context.read<UserCubit>().getUser();
                      return switch (state) {
                        UserLoading() => const Loading(),
                        UserLoggedIn() => Scaffold(
                            resizeToAvoidBottomInset: false,
                            body: [
                              isFirst ? HomeScreen(user: state.user) : ProfileScreen(user: state.user),
                              const MateriScreen(),
                              const QuizScreen(),
                              ProfileScreen(user: state.user),
                            ][index],
                            bottomNavigationBar: BottomNavigationBar(
                              backgroundColor: Colors.white,
                              onTap: (value) {
                                if (isFirstValue.value == false) isFirstValue.value = true;
                                currentIndex.value = value;
                              },
                              type: BottomNavigationBarType.fixed,
                              currentIndex: index,
                              selectedItemColor: AppPalette.primaryColor,
                              selectedLabelStyle: TextAppStyle.urbanistMedium.copyWith(
                                fontSize: 14,
                              ),
                              unselectedLabelStyle: TextAppStyle.urbanistMedium,
                              items: const [
                                BottomNavigationBarItem(
                                  activeIcon: Icon(
                                    Icons.home,
                                    color: AppPalette.primaryColor,
                                  ),
                                  icon: Icon(Icons.home),
                                  label: 'Home',
                                ),
                                BottomNavigationBarItem(
                                  activeIcon: Icon(
                                    Icons.menu_book_rounded,
                                    color: AppPalette.primaryColor,
                                  ),
                                  icon: Icon(Icons.menu_book_rounded),
                                  label: 'Materi',
                                ),
                                BottomNavigationBarItem(
                                  activeIcon: Icon(
                                    Icons.book,
                                    color: AppPalette.primaryColor,
                                  ),
                                  icon: Icon(Icons.book),
                                  label: 'Quiz',
                                ),
                                BottomNavigationBarItem(
                                  activeIcon: Icon(
                                    Icons.person,
                                    color: AppPalette.primaryColor,
                                  ),
                                  icon: Icon(Icons.person),
                                  label: 'Profile',
                                ),
                              ],
                            ),
                          ),
                        _ => const SizedBox()
                      };
                    },
                  );
                },
              );
            }),
      ),
    );
  }
}
