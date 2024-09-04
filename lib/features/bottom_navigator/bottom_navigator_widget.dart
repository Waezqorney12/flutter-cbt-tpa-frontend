// ignore_for_file: must_be_immutable, curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:test_potensial/core/shared/text_style/text_app_style.dart';
import 'package:test_potensial/core/theme/app_palette.dart';
import 'package:test_potensial/features/home/presentation/home_screen.dart';
import 'package:test_potensial/features/materi/presentation/materi_screen.dart';
import 'package:test_potensial/features/profile/presentation/profile_screen.dart';

import '../../core/provider/navigator_provider.dart';
import '../quiz/quiz_screen.dart';

class BottomNavigatorWidget extends StatelessWidget {
  BottomNavigatorWidget({super.key});

  ValueNotifier<int> currentIndex = ValueNotifier<int>(0);
  ValueNotifier<bool> isFirstValue = ValueNotifier<bool>(true);

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (isFirstValue.value == false) isFirstValue.value = true;
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
                  return Scaffold(
                    resizeToAvoidBottomInset: false,
                    body: [
                      isFirst ? const HomeScreen() : const ProfileScreen(),
                      const MateriScreen(),
                      const QuizScreen(),
                      const ProfileScreen(),
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
                  );
                },
              );
            }),
      ),
    );
  }
}
