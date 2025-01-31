
import 'package:flutter/material.dart';

import '../../../../../core/utils/debouncer.dart';

class QuizTeacherDetailFormController with ChangeNotifier {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController choiceA = TextEditingController();
  final TextEditingController choiceB = TextEditingController();
  final TextEditingController choiceC = TextEditingController();
  final TextEditingController choiceD = TextEditingController();

  final TextEditingController essayAnswerController = TextEditingController();

  final Debouncer debouncer = Debouncer(milliseconds: 500);
  final ScrollController scrollController = ScrollController();
  int currentMax = 2;
  int? questionId;
  String? imageFile;

  FocusNode questionNode = FocusNode();

  void controllersDispose() {
    debouncer.dispose();
    questionNode.dispose();
    scrollController.dispose();
    titleController.dispose();
    choiceA.dispose();
    choiceB.dispose();
    choiceC.dispose();
    choiceD.dispose();
  }
}
