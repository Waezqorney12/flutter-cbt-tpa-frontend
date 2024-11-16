import 'package:dio/dio.dart';
import 'package:test_potensial/core/infrastructure/network/dio_client.dart';
import 'package:test_potensial/core/message/server_exception.dart';
import 'package:test_potensial/core/token/token_local_datasource.dart';
import 'package:test_potensial/features/quiz/data/model/quiz_model.dart';
import 'package:test_potensial/features/quiz/domain/datasource/quiz_thumbnail_remote_datasource.dart';

class QuizThumbnailRemoteDatasourceImpl implements QuizThumbnailRemoteDatasource {
  final DioClient _client;
  final TokenLocalDatasource _tokenLocalDatasource;
  const QuizThumbnailRemoteDatasourceImpl(this._client, this._tokenLocalDatasource);

  @override
  Future<List<QuizThumbnailModel>> getQuizThumbnail({String? kategori}) async {
    try {
      final token = await _tokenLocalDatasource.getToken();
      final response = await _client.get(
        '/api/get-quiz-thumbnail/${kategori ?? ''}',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      final List<dynamic> data = response.data['data'];
      final List<QuizThumbnailModel> quiz = data.map((e) => QuizThumbnailModel.fromJson(e)).toList();
      return quiz;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
