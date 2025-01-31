import 'package:fpdart/fpdart.dart';
import 'package:test_potensial/core/message/failure_message.dart';
import 'package:test_potensial/core/utils/function_helper_utils.dart';
import 'package:test_potensial/core/utils/typedef_utils.dart';
import 'package:test_potensial/features/student/quiz_detail/domain/datasource/remote_quiz_detail_datasource.dart';
import 'package:test_potensial/features/student/quiz_detail/domain/entities/quiz_entities.dart';
import 'package:test_potensial/features/student/quiz_detail/domain/repository/quiz_detail_repository.dart';
import 'package:test_potensial/features/student/quiz_detail/domain/usecase/quiz_usecase.dart';

import '../../../../../core/utils/log.dart';

class QuizDetailRepositoryImpl implements QuizDetailRepository {
  final RemoteQuizDetailDatasource _remoteQuizDetailDatasource;
  const QuizDetailRepositoryImpl(this._remoteQuizDetailDatasource);
  @override
  FutureEither<QuizBaseResponseEntities> getQuizDetail(GetDetailQuizParams params) {
    return helperCall<QuizBaseResponseEntities>(
      apiCall: () => _remoteQuizDetailDatasource.getQuizDetail(params),
    );
  }


  @override
  FutureEither<String> userExit({required int quizId, required List<List<dynamic>> data}) async {
    try {
      final request = await _remoteQuizDetailDatasource.userExit(quizId: quizId, data: data);
      return right(request);
    } catch (e) {
      Log.loggerError("Failure error in repository: $e");
      return left(FailureMessage("Failure error in repository: $e"));
    }
  }
}
