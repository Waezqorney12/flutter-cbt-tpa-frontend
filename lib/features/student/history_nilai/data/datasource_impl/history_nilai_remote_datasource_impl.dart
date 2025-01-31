import 'package:dio/dio.dart';
import 'package:test_potensial/core/message/server_exception.dart';
import 'package:test_potensial/core/infrastructure/network/dio_client.dart';
import 'package:test_potensial/core/token/token_local_datasource.dart';
import 'package:test_potensial/core/utils/log.dart';
import 'package:test_potensial/features/student/history_nilai/data/model/history_nilai_model.dart';
import 'package:test_potensial/features/student/history_nilai/domain/datasource/history_nilai_remote_datasource.dart';

class HistoryNilaiRemoteDatasourceImpl implements HistoryNilaiRemoteDatasource {
  final TokenLocalDatasource _tokenLocalDatasource;
  final DioClient _dioClient;
  HistoryNilaiRemoteDatasourceImpl(this._tokenLocalDatasource, this._dioClient);
  @override
  Future<List<HistoryNilaiModel>> getHistoryNilai() async {
    try {
      final String? token = await _tokenLocalDatasource.getToken();
      if (token == null) {
        throw const ServerException(message: 'Token is null');
      }
      final response = await _dioClient.get('/api/nilai', options: Options(headers: {'Authorization': 'Bearer $token'}));
      final List<HistoryNilaiModel> historyNilai = (response.data as List).map((e) => HistoryNilaiModel.fromJson(e)).toList();
      Log.loggerInformation('Response: $historyNilai');
      return historyNilai;
    } catch (e) {
      throw ServerException(message: 'Server Exception: $e');
    }
  }
}
