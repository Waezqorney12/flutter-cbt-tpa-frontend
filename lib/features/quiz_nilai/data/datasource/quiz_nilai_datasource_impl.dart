import 'package:dio/dio.dart';
import 'package:test_potensial/core/infrastructure/network/dio_client.dart';
import 'package:test_potensial/core/token/token_local_datasource.dart';
import 'package:test_potensial/core/utils/log.dart';
import 'package:test_potensial/features/quiz_nilai/data/model/quiz_nilai_model.dart';
import 'package:test_potensial/features/quiz_nilai/domain/datasource/quiz_nilai_datasource.dart';

import '../../../../core/failure/server_exception.dart';

final class QuizNilaiDatasourceImpl implements QuizNilaiDatasource {
  final DioClient _dioClient;
  final TokenLocalDatasource _tokenLocalDatasource;
  const QuizNilaiDatasourceImpl(this._dioClient, this._tokenLocalDatasource);

  @override
  Future<QuizNilaiModel> getNilaiQuiz(String params) async {
    try {
      final token = await _tokenLocalDatasource.getToken();
      final request = await _dioClient.get(
        '/api/get-hasil-nilai',
        queryParameters: {'kategori': params},
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      Log.loggerInformation('Response: ${request.data}');
      return QuizNilaiModel.fromJson(request.data);
    } on DioException catch (e) {
      Log.loggerFatal('Dio Error: $e');
      throw ServerException(message: 'Dio Exception: $e');
    } catch (e) {
      Log.loggerFatal('Server Error: $e');
      throw ServerException(message: 'Server Exception: $e');
    }
  }
}
