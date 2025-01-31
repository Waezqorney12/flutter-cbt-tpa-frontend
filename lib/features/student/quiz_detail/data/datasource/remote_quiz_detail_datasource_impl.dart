import 'package:dio/dio.dart';
import 'package:test_potensial/core/message/server_exception.dart';
import 'package:test_potensial/core/infrastructure/network/dio_client.dart';
import 'package:test_potensial/core/token/token_local_datasource.dart';
import 'package:test_potensial/core/utils/log.dart';
import 'package:test_potensial/features/student/quiz_detail/data/model/quiz_model.dart';
import 'package:test_potensial/features/student/quiz_detail/domain/datasource/remote_quiz_detail_datasource.dart';
import 'package:test_potensial/features/student/quiz_detail/domain/usecase/quiz_usecase.dart';

class RemoteQuizDetailDatasourceImpl implements RemoteQuizDetailDatasource {
  final TokenLocalDatasource _tokenLocalDatasource;
  final DioClient _dioClient;
  const RemoteQuizDetailDatasourceImpl(this._tokenLocalDatasource, this._dioClient);
  @override
  Future<QuizBaseResponseModel> getQuizDetail(GetDetailQuizParams params) async {
    try {
      final token = await _tokenLocalDatasource.getToken();
      final response = await _dioClient.get(
        '/api/get-detail-quizzes',
        queryParameters: {'quiz_id': params.id, 'type': params.type},
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      final QuizBaseResponseModel responseQuizzes = QuizBaseResponseModel.fromJson(response.data);
      Log.loggerInformation('Response: ${responseQuizzes.message}');
      return responseQuizzes;
    } catch (e) {
      Log.loggerFatal('Server Exception: $e');
      throw ServerException(message: 'Server Exception: $e');
    }
  }


  @override
  Future<String> userExit({required int quizId, required List<List<dynamic>> data}) async {
    try {
      final String? token = await _tokenLocalDatasource.getToken();
      final response = await _dioClient.put(
        '/api/exit-quiz',
        data: {
          "quiz_id": quizId,
          "data": data,
        },
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      final String message = response.data['message'];
      return message;
    } catch (e) {
      throw ServerException(message: 'Server Exception: $e');
    }
  }
}
