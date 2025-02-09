import 'package:dio/dio.dart';
import 'package:test_potensial/core/message/server_exception.dart';
import 'package:test_potensial/core/infrastructure/network/dio_client.dart';
import 'package:test_potensial/core/token/token_local_datasource.dart';
import 'package:test_potensial/core/utils/log.dart';
import 'package:test_potensial/features/student/materi/data/model/materi_model.dart';
import 'package:test_potensial/features/student/materi/domain/datasource/materi_remote_datasource.dart';

class MateriRemoteDatasourceImpl implements MateriRemoteDataSource {
  final DioClient _dioClient;
  final TokenLocalDatasource _tokenLocalDatasource;
  MateriRemoteDatasourceImpl(this._dioClient, this._tokenLocalDatasource);
  @override
  Future<List<MateriModel>> getMateri({String? kategori}) async {
    try {
      final token = await _tokenLocalDatasource.getToken();
      final json = await _dioClient.get(
        kategori != null ? '/api/get-materi/$kategori' : '/api/get-materi',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      final baseResponse = MateriBaseResponse.fromJson(json.data);
      return baseResponse.materi;
    } catch (e) {
      Log.loggerFatal('Datasources fail: $e');
      throw ServerException(message: 'Terjadi kesalahan pada server: $e');
    }
  }

  @override
  Future<String> updateMateri(
    int id,
    int status,
  ) async {
    try {
      final token = await _tokenLocalDatasource.getToken();
      final response = await _dioClient.put(
        '/api/update-status',
        data: {
          'materi_id': id,
          'status': status,
        },
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
          validateStatus: (status) {
            Log.loggerWarning('Status Code: $status');
            return status! < 500;
          },
        ),
      );
      Log.loggerInformation('Update Materi: ${response.data}');
      return response.data['message'];
    } on DioException catch (e) {
      //Log.loggerFatal('Dio Exception: $e');
      throw ServerException(message: 'Dio Exception: $e');
    } catch (e) {
      //Log.loggerFatal('Server Exception: $e');
      throw ServerException(message: 'Server Exception: $e');
    }
  }
}
