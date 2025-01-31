import 'package:test_potensial/core/utils/typedef_utils.dart';
import 'package:test_potensial/features/student/quiz/domain/entities/quiz_thumbnail_entities.dart';

abstract interface class QuizThumbnailRepository {
  FutureEither<List<QuizThumbnailEntities>> getQuizThumbnail({String? kategori});
}
