import 'package:flutter/material.dart';
import 'package:test_potensial/core/utils/extension_utils.dart';

import '../../../../../core/shared/positioned/dimensions.dart';
import '../../../../../core/shared/text_style/text_app_style.dart';
import '../../../../../core/theme/app_palette.dart';
import '../../bloc/quiz_detail_bloc.dart';


Positioned quizzesNumber({
  required BuildContext context,
  required QuizDetailLoaded state,
  required int currentIndex,
}) {
  return Positioned(
    top: state.responseQuizzes.quizEntities[currentIndex].quizDetails.quizImagePath != null
        ? Dimensions.minHeight35(context)
        : Dimensions.minHeight45(context),
    left: 0,
    right: 0,
    child: Align(
      alignment: Alignment.topCenter,
      child: Container(
        width: 90,
        height: 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: AppPalette.greyBlue,
        ),
        child: Text(
          '${currentIndex + 1}/${state.responseQuizzes.quizEntities.length}',
          style: TextAppStyle.montserratMedium.copyWith(
            fontSize: 16,
            color: Colors.white,
          ),
        ).center(),
      ),
    ),
  );
}
