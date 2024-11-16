// ignore_for_file: unused_element

import 'dart:async';

import 'package:dio/dio.dart';
import 'package:test_potensial/core/entities/user_entities.dart';
import 'package:test_potensial/core/infrastructure/network/dio_client.dart';
import 'package:test_potensial/core/token/flutter_secure_store.dart';
import 'package:test_potensial/core/utils/log.dart';

import '../message/server_exception.dart';
import '../model/user_model.dart';

abstract interface class TokenLocalDatasource {
  Future<String?> getToken();
  Future<void> removeToken();
  Future<void> saveAccessToken(String token);
  Future<UserEntities> getUser();
}

class TokenLocalDatasourceImpl implements TokenLocalDatasource {
  final SharedPreferencesSecureInterface _secureStorage;
  final DioClient _client;

  TokenLocalDatasourceImpl(
    this._secureStorage,
    this._client,
  );

  @override
  Future<String?> getToken() async => _secureStorage.get('access_token');

  @override
  Future<void> removeToken() async => _secureStorage.remove('access_token');

  @override
  Future<void> saveAccessToken(String token) {
    return _secureStorage.store('access_token', token);
  }

  @override
  Future<UserEntities> getUser() async {
    try {
      final token = await getToken();
      Log.loggerFatal("Token remotedatasource: $token");
      if (token == null) throw const ServerException(message: 'No access token available');
      final response = await _client.get(
        '/api/get-user',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      return UserModel.fromJson(response.data['data']);
    } on DioException catch (e) {
      Log.loggerFatal("Dio Error: ${e.message}");
      rethrow;
    } on ServerException catch (e) {
      throw ServerException(message: 'Server Error: $e');
    }
  }
}
