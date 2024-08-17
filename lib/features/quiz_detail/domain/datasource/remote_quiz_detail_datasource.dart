import 'package:test_potensial/features/quiz_detail/data/model/quiz_model.dart';

abstract interface class RemoteQuizDetailDatasource {
  Future<List<QuizModel>> getQuizDetail(String kategori);
}
