import 'package:dio/dio.dart';
import 'package:test_potensial/core/failure/server_exception.dart';
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
      final data = response.data['data'] as List;
      return data.map((e) => QuizModel.fromJson(e)).toList();
    } on DioException catch (e) {
      Log.loggerFatal('Dio Exception: $e');
      throw ServerException(message: 'Dio Exception: $e');
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
      Log.loggerInformation('Response: ${request.data['message']}');
      return request.data['message'];
    } on DioException catch (e) {
      throw ServerException(message: 'Dio Exception: $e');
    } catch (e) {
      throw ServerException(message: 'Server Exception: $e');
    }
  }
}
