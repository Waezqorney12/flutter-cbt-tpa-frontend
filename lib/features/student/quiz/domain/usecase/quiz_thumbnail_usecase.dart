import 'package:test_potensial/core/usecases/usecase_interface.dart';
import 'package:test_potensial/core/utils/typedef_utils.dart';
import 'package:test_potensial/features/student/quiz/domain/entities/quiz_thumbnail_entities.dart';

import '../repository/quiz_thumbnail_repository.dart';

class QuizThumbnailUsecase implements UseCase<List<QuizThumbnailEntities>, String> {
  final QuizThumbnailRepository _repository;
  const QuizThumbnailUsecase(this._repository);

  @override
  FutureEither<List<QuizThumbnailEntities>> call(String? kategori) async {
    return _repository.getQuizThumbnail(kategori: kategori);
  }
}
