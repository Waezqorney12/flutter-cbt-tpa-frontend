import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_potensial/core/entities/user_entities.dart';
import 'package:test_potensial/core/infrastructure/network/dio_client.dart';
import 'package:test_potensial/core/token/flutter_secure_store.dart';
import 'package:test_potensial/core/token/shared_preferences.dart';
import 'package:test_potensial/core/utils/log.dart';

import '../message/server_exception.dart';
import '../model/user_model.dart';

abstract interface class TokenLocalDatasource {
  Future<bool> saveRefreshToken(String token);
  Future<String?> getToken();
  Future<String?> getAccessToken();
  Future<UserEntities> getUser();
  Future<bool> removeToken();
  Future<void> saveAccessToken(String token);
}

class TokenLocalDatasourceImpl implements TokenLocalDatasource {
  final DioClient _client;
  final SharedPreferencesInterface _sharedPreferences;
  final SharedPreferencesSecureInterface _secureStorage;
  const TokenLocalDatasourceImpl(
    this._client,
    this._sharedPreferences,
    this._secureStorage,
  );

  @override
  Future<bool> saveRefreshToken(String token) async => await _sharedPreferences.addString('refresh_token', token);

  @override
  Future<String?> getToken() async => _sharedPreferences.readString('refresh_token');

  @override
  Future<UserEntities> getUser() async {
    try {
      final token = await _sharedPreferences.readString('refresh_token');
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
  Future<bool> removeToken() async => _sharedPreferences.remove('refresh_token');

  @override
  Future<void> saveAccessToken(String token) {
    return _secureStorage.store('access_token', token);
  }

  @override
  Future<String?> getAccessToken() async => _secureStorage.get('access_token');
}
