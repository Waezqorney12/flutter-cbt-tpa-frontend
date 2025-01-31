import 'package:flutter/material.dart';
import 'package:test_potensial/core/theme/app_palette.dart';

class KelasTeacherController {
  bool isClicked = false;
  FocusNode focusNode = FocusNode();
  int currentIndex = 0;
  List<Color> determineColor = [Colors.purple, AppPalette.primaryColor];
  TextEditingController searchController = TextEditingController();

  void dispose() {
    focusNode.dispose();
    searchController.dispose();
  }
}

enum IndicatorColor { materi, quiz }

enum IconCard { pin, materi, quiz }
