import 'dart:io';

import 'package:test_potensial/core/utils/typedef_utils.dart';

abstract class QuizTeacherDetailFormQuestionRepository {
  FutureEither<String> createQuestion({
    required String questionName,
    File? imageFile,
  });
}
