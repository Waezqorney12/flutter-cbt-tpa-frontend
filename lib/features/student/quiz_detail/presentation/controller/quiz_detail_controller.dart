import 'package:flutter/material.dart';
import 'package:test_potensial/core/theme/app_palette.dart';
import 'package:test_potensial/features/student/quiz_detail/domain/entities/quiz_entities.dart';

class QuizDetailController {
  List<Map<String, String>> shuffleOptions(QuizzesDetailsEntities quiz) {
    final List<Map<String, String>> choicesOption = [
      {'option': 'A', 'value': quiz.choiceA ?? ''},
      {'option': 'B', 'value': quiz.choiceB ?? ''},
      {'option': 'C', 'value': quiz.choiceC ?? ''},
      {'option': 'D', 'value': quiz.choiceD ?? ''},
    ];

    choicesOption.shuffle();
    return choicesOption;
  }

  List<Map<String, Color>> buttonColorOptions() {
    return [
      {'blendColor': AppPalette.blendPrimaryDark, 'color': AppPalette.buttonRed},
      {'blendColor': AppPalette.buttonBlendYellow, 'color': AppPalette.buttonYellow},
      {'blendColor': AppPalette.buttonBlendGreen, 'color': AppPalette.buttonGreen},
      {'blendColor': AppPalette.buttonBlendBlue, 'color': AppPalette.buttonBlue},
    ];
  }
}
