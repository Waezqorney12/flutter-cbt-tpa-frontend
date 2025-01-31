import 'package:test_potensial/core/utils/function_helper_utils.dart';
import 'package:test_potensial/core/utils/typedef_utils.dart';
import 'package:test_potensial/features/student/quiz/domain/entities/quiz_thumbnail_entities.dart';
import '../../domain/datasource/quiz_thumbnail_remote_datasource.dart';
import '../../domain/repository/quiz_thumbnail_repository.dart';

class QuizThumbnailRepositoryImpl implements QuizThumbnailRepository {
  final QuizThumbnailRemoteDatasource _quizDetailDatasource;
  const QuizThumbnailRepositoryImpl(this._quizDetailDatasource);

  @override
  FutureEither<List<QuizThumbnailEntities>> getQuizThumbnail({String? kategori}) {
    return helperCall<List<QuizThumbnailEntities>>(
      apiCall: () => _quizDetailDatasource.getQuizThumbnail(kategori: kategori),
    );
  }
}
