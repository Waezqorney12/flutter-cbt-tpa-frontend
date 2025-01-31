import 'dart:io';

import 'package:test_potensial/core/utils/function_helper_utils.dart';
import 'package:test_potensial/core/utils/typedef_utils.dart';
import 'package:test_potensial/features/teacher/quiz_teacher_detail_form/domain/remote_datasource/quiz_teacher_detail_form_question_remote_datasource.dart';
import '../../domain/repository/quiz_teacher_detail_form_question_repository.dart';

class QuizTeacherDetailFormQuestionRepositoryImpl implements QuizTeacherDetailFormQuestionRepository {
  final QuizTeacherDetailFormQuestionRemoteDatasource _datasource;
  QuizTeacherDetailFormQuestionRepositoryImpl(this._datasource);
  @override
  FutureEither<String> createQuestion({
    required String questionName,
    File? imageFile,
  }) async {
    return helperCall<String>(
      apiCall: () => _datasource.createQuestion(
        questionName: questionName,
        imageFile: imageFile,
      ),
    );
  }
}
