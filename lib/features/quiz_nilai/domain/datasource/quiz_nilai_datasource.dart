import 'package:test_potensial/features/quiz_nilai/data/model/quiz_nilai_model.dart';

abstract interface class QuizNilaiDatasource {
  Future<QuizNilaiModel> getNilaiQuiz(String params);
}
