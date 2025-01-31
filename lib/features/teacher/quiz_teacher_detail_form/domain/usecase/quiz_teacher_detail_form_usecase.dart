import 'package:test_potensial/core/usecases/usecase_interface.dart';
import 'package:test_potensial/core/utils/typedef_utils.dart';
import 'package:test_potensial/features/teacher/quiz_teacher_detail_form/domain/entities/quiz_question_entities.dart';
import 'package:test_potensial/features/teacher/quiz_teacher_detail_form/domain/repository/quiz_teacher_detail_form_repository.dart';

class QuizTeacherDetailFormUsecase implements UseCase<List<QuizQuestionEntities>, String> {
  final QuizTeacherDetailFormRepository _repository;
  const QuizTeacherDetailFormUsecase(this._repository);

  

  @override
  FutureEither<List<QuizQuestionEntities>> call(String? name) {
    return _repository.getQuestion(name: name);
  }
}
