import 'package:flutter/material.dart';
import 'package:test_potensial/core/routes/routes_pages.dart';

import '../../../core/theme/app_palette.dart';

class HomeController {
  static TextEditingController searchController = TextEditingController();
  static List<String> imageHome = [
    'assets/home/tips.png',
    'assets/home/materi.png',
    'assets/home/quiz.png',
    'assets/home/about.png',
  ];
  static List<String> contentHome = ['Tips & Trick', 'Materi', 'Quiz', 'About Us'];
  static List<Color> boxColor = [AppPalette.box0, AppPalette.box1, AppPalette.box2, AppPalette.box3];
  static List<int> routesNumber = [0, 1, 2, 3];
  static List<MaterialPageRoute Function()> routes = [
    () => Routes.materi(),
    () => Routes.materi(),
    () => Routes.quiz(),
    () => Routes.aboutUs(),
  ];
}
