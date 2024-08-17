import 'package:fpdart/fpdart.dart';
import 'package:test_potensial/core/failure/failure_message.dart';

import '../entities/quiz_entities.dart';

abstract interface class QuizDetailRepository {
  Future<Either<FailureMessage, List<QuizEntities>>> getQuizDetail(String kategori);
}
