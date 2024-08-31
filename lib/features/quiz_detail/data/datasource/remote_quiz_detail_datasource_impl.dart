import 'package:dio/dio.dart';
import 'package:test_potensial/core/message/server_exception.dart';
import 'package:test_potensial/core/infrastructure/network/dio_client.dart';
import 'package:test_potensial/core/token/token_local_datasource.dart';
import 'package:test_potensial/core/utils/log.dart';
import 'package:test_potensial/features/quiz_detail/data/model/quiz_model.dart';
import 'package:test_potensial/features/quiz_detail/domain/datasource/remote_quiz_detail_datasource.dart';
import 'package:test_potensial/features/quiz_detail/domain/usecase/quiz_usecase.dart';

class RemoteQuizDetailDatasourceImpl implements RemoteQuizDetailDatasource {
  final TokenLocalDatasource _tokenLocalDatasource;
  final DioClient _dioClient;
  const RemoteQuizDetailDatasourceImpl(this._tokenLocalDatasource, this._dioClient);
  @override
  Future<List<QuizModel>> getQuizDetail(String kategori) async {
    try {
      final token = await _tokenLocalDatasource.getToken();
      final response = await _dioClient.get(
        '/api/get-soal-ujian',
        queryParameters: {'kategori': kategori},
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      ///Log.loggerInformation('Response: ${response.data['data']}');
      final List<QuizModel> quizList = (response.data['data'] as List).map((value) => QuizModel.fromJson(value)).toList();
      return quizList;
    } catch (e) {
      Log.loggerFatal('Server Exception: $e');
      throw ServerException(message: 'Server Exception: $e');
    }
  }

  @override
  Future<String> createJawabanDetail(CreateJawabanParams params) async {
    try {
      final token = await _tokenLocalDatasource.getToken();
      final request = await _dioClient.post(
        '/api/answers',
        data: params.toJson(),
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      return request.data['message'];
    } catch (e) {
      throw ServerException(message: 'Server Exception: $e');
    }
  }

  @override
  void userExit(List<int> soalId) async {
    try {
      final String? token = await _tokenLocalDatasource.getToken();
      _dioClient.post(
        '/api/exit',
        data: {'soal_id': soalId},
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
    } catch (e) {
      throw ServerException(message: 'Server Exception: $e');
    }
  }
}
