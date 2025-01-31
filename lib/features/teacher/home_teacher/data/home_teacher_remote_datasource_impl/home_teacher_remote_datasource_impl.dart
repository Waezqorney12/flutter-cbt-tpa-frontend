import 'package:dio/dio.dart';
import 'package:test_potensial/core/infrastructure/network/dio_client.dart';
import 'package:test_potensial/core/token/token_local_datasource.dart';
import 'package:test_potensial/features/teacher/home_teacher/data/model/kelas_model.dart';
import 'package:test_potensial/features/teacher/home_teacher/domain/home_teacher_remote_datasource/home_teacher_remote_datasource.dart';

class HomeTeacherRemoteDatasourceImpl implements HomeTeacherRemoteDatasource {
  final DioClient _client;
  final TokenLocalDatasource _token;
  const HomeTeacherRemoteDatasourceImpl(this._client, this._token);
  @override
  Future<String> createClass({
    required String className,
    String? classDescription,
  }) async {
    final token = await _token.getToken();
    final request = await _client.post('/api/create-class',
        data: ClassModel(className: className, classDescription: classDescription).toJson(),
        options: Options(headers: {'Authorization': 'Bearer $token'}));
    final response = request.data['message'];
    return response;
  }

  @override
  Future<List<ClassModel>> getClass() async {
    final token = await _token.getToken();
    final request = await _client.get(
      '/api/get-class',
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );

    final List<dynamic> data = request.data['data'];
    final List<ClassModel> response = data.map((value) => ClassModel.fromJson(value)).toList();
    return response;
  }
}
