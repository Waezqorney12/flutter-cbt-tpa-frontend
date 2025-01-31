import 'package:test_potensial/core/utils/typedef_utils.dart';
import 'package:test_potensial/features/student/quiz_detail/domain/usecase/quiz_usecase.dart';

import '../entities/quiz_entities.dart';

abstract interface class QuizDetailRepository {
  FutureEither<QuizBaseResponseEntities> getQuizDetail(GetDetailQuizParams params);
  FutureEither<String> userExit({required int quizId, required List<List<dynamic>> data});
  //FutureEither<
}
