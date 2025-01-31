import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_potensial/core/utils/pick_image_utils.dart';

import '../../../../../core/utils/log.dart';
import '../../cubit/quiz_detail_form_question/quiz_detail_form_question_cubit.dart';
import '../../domain/usecase/quiz_teacher_detail_form_question_usecase.dart';

class QuizTeacherDetailFormQuestionController {
  TextEditingController titleController = TextEditingController();
  File? fileImage;

  FocusNode titleNode = FocusNode();

  Future addImage() async {
    final imageFile = await pickImage();
    if (imageFile != null) fileImage = imageFile;

    Log.loggerInformation("Image: $fileImage");
  }

  void addNewQuestion({required BuildContext context}) {
    context.read<QuizDetailFormQuestionCubit>().createQuestion(
          QuizTeacherDetailFormParams(
            questionName: titleController.text,
            imageFile: fileImage,
          ),
        );
  }

  void dispose() {
    titleController.dispose();
    titleNode.dispose();
  }
}
