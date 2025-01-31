import 'package:test_potensial/features/student/quiz_detail/domain/usecase/quiz_usecase.dart';
import 'package:test_potensial/features/student/quiz_nilai/data/model/quiz_nilai_model.dart';

abstract interface class QuizNilaiDatasource {
  Future<QuizNilaiModel> getNilaiQuiz({required UserQuizParams params});
}
