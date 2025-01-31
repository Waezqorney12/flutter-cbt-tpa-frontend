import 'dart:io';

import 'package:test_potensial/core/usecases/usecase_interface.dart';
import 'package:test_potensial/core/utils/typedef_utils.dart';
import 'package:test_potensial/features/teacher/quiz_teacher_detail_form/domain/repository/quiz_teacher_detail_form_question_repository.dart';

class QuizTeacherDetailFormQuestionUsecase implements UseCase<String, QuizTeacherDetailFormParams> {
  final QuizTeacherDetailFormQuestionRepository _repository;
  const QuizTeacherDetailFormQuestionUsecase(this._repository);

  @override
  FutureEither<String> call(QuizTeacherDetailFormParams params) {
    return _repository.createQuestion(
      imageFile: params.imageFile,
      questionName: params.questionName,
    );
  }
}

class QuizTeacherDetailFormParams {
  final File? imageFile;
  final String questionName;
  const QuizTeacherDetailFormParams({
    this.imageFile,
    required this.questionName,
  });
}
