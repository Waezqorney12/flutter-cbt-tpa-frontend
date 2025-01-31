import 'dart:io';

abstract class QuizTeacherDetailFormQuestionRemoteDatasource {
  Future<String> createQuestion({
    required String questionName,
    File? imageFile,
  });
}
