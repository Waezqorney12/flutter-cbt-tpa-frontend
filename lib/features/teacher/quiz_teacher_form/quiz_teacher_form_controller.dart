import 'dart:io';

import 'package:flutter/material.dart';
import 'package:test_potensial/core/utils/log.dart';
import 'package:test_potensial/features/teacher/quiz_teacher_form/domain/entities/form_quiz_entities.dart';

import '../../../core/entities/user_entities.dart';
import '../../../core/utils/pick_image_utils.dart';

class QuizTeacherFormController with ChangeNotifier {
  String? selectedCategory;
  String? selectedType;
  List<FormQuizEntities> questionList = [];
  List<UserEntities> studentList = [];
  File? thumbnailImage;

  String? setType;
  String? setCategory;

  void addQuiz({required FormQuizEntities quiz}) {
    Log.loggerInformation(quiz);
    questionList.add(quiz);
    notifyListeners();
  }

  Future addImage() async {
    final imagePath = await pickImage();
    if (imagePath != null) thumbnailImage = imagePath;
  }
}

enum CategoryQuiz { logika, numeric, verbal }

enum TypeQuiz { choice, essay }
