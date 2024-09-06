import 'dart:async';

import 'package:dio/dio.dart';
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
  Stream<UserEntities> getUser();
  Future<bool> removeToken();
  Future<void> saveAccessToken(String token);
  Future _startUserPolling();
  Future _fetchUserData();

  void updateUserData(UserModel user);
}

class TokenLocalDatasourceImpl implements TokenLocalDatasource {
  final DioClient _client;
  final SharedPreferencesInterface _sharedPreferences;
  final SharedPreferencesSecureInterface _secureStorage;
  final StreamController<UserModel> _streamController = StreamController<UserModel>.broadcast();

  TokenLocalDatasourceImpl(
    this._client,
    this._sharedPreferences,
    this._secureStorage,
  ) {
    _startUserPolling();
  }

  @override
  Future<bool> saveRefreshToken(String token) async => await _sharedPreferences.addString('refresh_token', token);

  @override
  Future<String?> getToken() async => _sharedPreferences.readString('refresh_token');

  @override
  Stream<UserEntities> getUser() => _streamController.stream;

  @override
  Future _startUserPolling() async {
    await _fetchUserData();
    Timer.periodic(
      const Duration(seconds: 15),
      (timer) async {
        await _fetchUserData();
      },
    );
  }

  @override
  Future<bool> removeToken() async => _sharedPreferences.remove('refresh_token');

  @override
  Future<void> saveAccessToken(String token) {
    return _secureStorage.store('access_token', token);
  }

  @override
  Future<String?> getAccessToken() async => _secureStorage.get('access_token');

  @override
  Future _fetchUserData() async {
    try {
      final token = await _sharedPreferences.readString('refresh_token');
      if (token == null) throw const ServerException(message: 'Token is null');
      final response = await _client.get(
        '/api/user',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
          validateStatus: (status) {
            switch (status) {
              case 401:
                throw const ServerException(message: 'Unauthorized');
              case 403:
                throw const ServerException(message: 'Forbidden');
              case 429:
                throw const ServerException(message: 'Too Many Requests');
              default:
            }
            return status! < 500;
          },
        ),
      );
      final user = UserModel.fromJson(response.data);
      Log.loggerWarning('TokenLocalDatasourceImpl Fetch User Data: ${user.toJson()}');
      _streamController.add(user);
    } catch (e) {
      _streamController.addError(e);
    }
  }

  @override
  void updateUserData(UserModel user) => _streamController.add(user);
}
