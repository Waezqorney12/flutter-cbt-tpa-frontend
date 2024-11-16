import 'package:test_potensial/features/quiz/data/model/quiz_model.dart';

abstract interface class QuizThumbnailRemoteDatasource {
Future<List<QuizThumbnailModel>> getQuizThumbnail({String? kategori});
}
