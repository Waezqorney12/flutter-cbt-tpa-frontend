import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_potensial/core/entities/user_entities.dart';
import 'package:test_potensial/core/infrastructure/network/dio_client.dart';
import 'package:test_potensial/core/utils/log.dart';

import '../failure/server_exception.dart';
import '../model/user_model.dart';

abstract interface class TokenLocalDatasource {
  Future<void> saveToken(String token);
  Future<String?> getToken();
  Future<UserEntities> getUser();
  Future removeToken();
}

class TokenLocalDatasourceImpl implements TokenLocalDatasource {
  final DioClient _client;
  final SharedPreferences _sharedPreferences;
  const TokenLocalDatasourceImpl(this._sharedPreferences, this._client);

  @override
  Future<void> saveToken(String token) async => await _sharedPreferences.setString('access_token', token);

  @override
  Future<String?> getToken() async => _sharedPreferences.getString('access_token');

  @override
  Future<UserEntities> getUser() async {
    try {
      final token = _sharedPreferences.getString('access_token');
      if (token == null) throw const ServerException(message: 'Token is null');
      final response = await _client.get(
        '/api/user',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      return UserModel.fromJson(response.data);
    } on DioException catch (e) {
      Log.loggerFatal("Dio Error: ${e.message}");
      rethrow;
    } on ServerException catch (e) {
      throw ServerException(message: 'Server Error: $e');
    }
  }

  @override
  Future removeToken() async => await _sharedPreferences.remove('access_token');
}
