import 'package:fpdart/fpdart.dart';
import 'package:test_potensial/features/quiz_nilai/domain/entities/quiz_nilai_entities.dart';

import '../../../../core/message/failure_message.dart';

abstract interface class QuizNilaiRepository{
  Future<Either<FailureMessage, QuizNilaiEntities>> getNilaiQuiz(String params);
}