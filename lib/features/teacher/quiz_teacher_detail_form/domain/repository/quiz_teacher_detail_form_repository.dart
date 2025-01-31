import '../../../../../core/utils/typedef_utils.dart';
import '../entities/quiz_question_entities.dart';

abstract class QuizTeacherDetailFormRepository {
  FutureEither<List<QuizQuestionEntities>> getQuestion({String? name});
}
