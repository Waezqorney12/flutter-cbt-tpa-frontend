import 'package:test_potensial/core/utils/typedef_utils.dart';
import 'package:test_potensial/features/student/quiz_nilai/domain/datasource/quiz_nilai_datasource.dart';
import 'package:test_potensial/features/student/quiz_nilai/domain/entities/quiz_nilai_entities.dart';

import '../../../../../core/utils/function_helper_utils.dart';
import '../../../quiz_detail/domain/usecase/quiz_usecase.dart';
import '../../domain/repository/quiz_nilai_repository.dart';

final class QuizNilaiRepositoryImpl implements QuizNilaiRepository {
  final QuizNilaiDatasource _quizNilaiDatasource;
  const QuizNilaiRepositoryImpl(this._quizNilaiDatasource);

  @override
  FutureEither<QuizNilaiEntities> getNilaiQuiz({required UserQuizParams params}) {
    return helperCall<QuizNilaiEntities>(
      apiCall: () async => await _quizNilaiDatasource.getNilaiQuiz(params: params),
    );
  }
}
