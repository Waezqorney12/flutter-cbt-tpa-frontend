import 'package:dio/dio.dart';
import 'package:test_potensial/core/failure/server_exception.dart';
import 'package:test_potensial/core/infrastructure/network/dio_client.dart';
import 'package:test_potensial/core/token/token_local_datasource.dart';
import 'package:test_potensial/core/utils/log.dart';
import 'package:test_potensial/features/materi/data/model/materi_model.dart';
import 'package:test_potensial/features/materi/domain/datasource/materi_remote_datasource.dart';

class MateriRemoteDatasourceImpl implements MateriRemoteDataSource {
  final DioClient _dioClient;
  final TokenLocalDatasource _tokenLocalDatasource;
  MateriRemoteDatasourceImpl(this._dioClient, this._tokenLocalDatasource);
  @override
  Future<List<MateriModel>> getMateri() async {
    try {
      final token = await _tokenLocalDatasource.getToken();
      // Log.loggerInformation('Materi: $token');

      final data = await _dioClient.get(
        '/api/materis',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      //Log.loggerInformation('Materi Data: $data');
      return (data.data as List).map((e) => MateriModel.fromJson(e)).toList();
    } catch (e) {
      Log.loggerFatal('Datasources fail: $e');
      throw ServerException(message: 'Terjadi kesalahan pada server: $e');
    }
  }
}
