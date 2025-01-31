import 'package:test_potensial/features/student/quiz_detail/data/model/quiz_model.dart';

import '../usecase/quiz_usecase.dart';

abstract interface class RemoteQuizDetailDatasource {
  Future<QuizBaseResponseModel> getQuizDetail(GetDetailQuizParams params);
  Future<String> userExit({required int quizId, required List<List<dynamic>> data});
  //Future userScore({required UserQuizParams params});
}
