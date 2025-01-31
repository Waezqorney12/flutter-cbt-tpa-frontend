import '../../data/model/quiz_question_model.dart';

abstract class QuizTeacherDetailFormRemoteDatasource {
  
  Future<List<QuizQuestionModel>> getQuestion({String? name});
}
