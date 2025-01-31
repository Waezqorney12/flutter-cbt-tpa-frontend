import 'package:dio/dio.dart';
import 'package:test_potensial/core/infrastructure/network/dio_client.dart';
import 'package:test_potensial/core/token/token_local_datasource.dart';
import 'package:test_potensial/core/utils/log.dart';
import 'package:test_potensial/features/student/quiz_nilai/data/model/quiz_nilai_model.dart';
import 'package:test_potensial/features/student/quiz_nilai/domain/datasource/quiz_nilai_datasource.dart';

import '../../../../../core/message/server_exception.dart';
import '../../../quiz_detail/domain/usecase/quiz_usecase.dart';

final class QuizNilaiDatasourceImpl implements QuizNilaiDatasource {
  final DioClient _dioClient;
  final TokenLocalDatasource _tokenLocalDatasource;
  const QuizNilaiDatasourceImpl(this._dioClient, this._tokenLocalDatasource);

  @override
  Future<QuizNilaiModel> getNilaiQuiz({required UserQuizParams params}) async {
    try {
      final token = await _tokenLocalDatasource.getToken();
      Log.loggerWarning('Params: ${params.quizId} ${params.data}');
      final request = await _dioClient.put(
        '/api/show-score-quiz',
        data: {
          "quiz_id": params.quizId,
          "data": params.data,
        },
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      final data = request.data['data'];
      Log.loggerInformation('Req: ${request.data}');
      return QuizNilaiModel.fromJson(data);
    } on DioException catch (e) {
      Log.loggerFatal('Dio Error: $e');
      throw ServerException(message: 'Dio Exception: $e');
    } catch (e) {
      Log.loggerFatal('Server Error: $e');
      throw ServerException(message: 'Server Exception: $e');
    }
  }
}
