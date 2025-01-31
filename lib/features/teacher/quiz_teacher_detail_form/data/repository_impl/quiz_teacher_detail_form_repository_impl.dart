import 'package:test_potensial/core/utils/function_helper_utils.dart';
import 'package:test_potensial/core/utils/typedef_utils.dart';
import 'package:test_potensial/features/teacher/quiz_teacher_detail_form/domain/remote_datasource/quiz_teacher_detail_form_remote_datasource.dart';
import 'package:test_potensial/features/teacher/quiz_teacher_detail_form/domain/repository/quiz_teacher_detail_form_repository.dart';

import '../../domain/entities/quiz_question_entities.dart';

class QuizTeacherDetailFormRepositoryImpl implements QuizTeacherDetailFormRepository {
  final QuizTeacherDetailFormRemoteDatasource _datasource;
  const QuizTeacherDetailFormRepositoryImpl(this._datasource);
  @override
  FutureEither<List<QuizQuestionEntities>> getQuestion({String? name}) async {
    return helperCall<List<QuizQuestionEntities>>(
      apiCall: () => _datasource.getQuestion(name: name),
    );
  }
}
