import 'package:test_potensial/core/utils/typedef_utils.dart';
import 'package:test_potensial/features/student/quiz_nilai/domain/entities/quiz_nilai_entities.dart';

import '../../../quiz_detail/domain/usecase/quiz_usecase.dart';

abstract interface class QuizNilaiRepository {
  FutureEither<QuizNilaiEntities> getNilaiQuiz({required UserQuizParams params});
}
