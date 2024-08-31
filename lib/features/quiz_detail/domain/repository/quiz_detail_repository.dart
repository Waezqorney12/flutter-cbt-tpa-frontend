import 'package:test_potensial/core/utils/typedef_utils.dart';
import 'package:test_potensial/features/quiz_detail/domain/usecase/quiz_usecase.dart';

import '../entities/quiz_entities.dart';

abstract interface class QuizDetailRepository {
  FutureEither<List<QuizEntities>> getQuizDetail(String kategori);
  FutureEither<String> createJawabanDetail(CreateJawabanParams params);
  PresentEither<void> userExit(List<int> soalId);
}
