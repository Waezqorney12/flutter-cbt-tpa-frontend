import 'package:test_potensial/features/quiz_detail/data/model/quiz_model.dart';

import '../usecase/quiz_usecase.dart';

abstract interface class RemoteQuizDetailDatasource {
  Future<List<QuizModel>> getQuizDetail(String kategori);
  Future<String> createJawabanDetail(CreateJawabanParams params);
  
}
