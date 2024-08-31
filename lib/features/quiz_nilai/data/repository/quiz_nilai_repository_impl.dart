import 'package:fpdart/fpdart.dart';
import 'package:test_potensial/features/quiz_nilai/domain/datasource/quiz_nilai_datasource.dart';
import 'package:test_potensial/features/quiz_nilai/domain/entities/quiz_nilai_entities.dart';

import '../../../../core/message/failure_message.dart';
import '../../../../core/utils/function_helper_utils.dart';
import '../../domain/repository/quiz_nilai_repository.dart';

final class QuizNilaiRepositoryImpl implements QuizNilaiRepository {
  final QuizNilaiDatasource _quizNilaiDatasource;
  const QuizNilaiRepositoryImpl(this._quizNilaiDatasource);

  @override
  Future<Either<FailureMessage, QuizNilaiEntities>> getNilaiQuiz(String params) {
    return helperCall<QuizNilaiEntities>(
      apiCall: () => _quizNilaiDatasource.getNilaiQuiz(params),
    );
  }
}
