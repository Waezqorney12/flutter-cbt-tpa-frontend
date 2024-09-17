// ignore_for_file: unused_element

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:test_potensial/core/entities/user_entities.dart';
import 'package:test_potensial/core/infrastructure/network/websocket_client.dart';
import 'package:test_potensial/core/token/flutter_secure_store.dart';
import 'package:test_potensial/core/token/shared_preferences.dart';
import 'package:test_potensial/core/utils/log.dart';

import '../model/user_model.dart';

ValueNotifier<bool> isLoggedIn = ValueNotifier<bool>(false);

abstract interface class TokenLocalDatasource {
  Future<bool> saveRefreshToken(String token);
  Future<String?> getToken();
  Future<String?> getAccessToken();
  Stream<UserEntities> getUser();
  Future<bool> removeToken();
  Future<void> saveAccessToken(String token);
  Future<bool> isTokenAvailable();

  void updateUserData(UserModel user);
  void _isTokenAvailable();
  Future startWebSocket();
  void disposeWebSocket();
}

class TokenLocalDatasourceImpl implements TokenLocalDatasource {
  //final DioClient _client;
  final SharedPreferencesInterface _sharedPreferences;
  final SharedPreferencesSecureInterface _secureStorage;
  final StreamController<UserModel> _streamController = StreamController<UserModel>.broadcast();
  late WebsocketClient _webSocketService;

  TokenLocalDatasourceImpl(
    //this._client,
    this._sharedPreferences,
    this._secureStorage,
  ) {
    isLoggedIn.addListener(() {
      if (isLoggedIn.value == true) {
        _isTokenAvailable();
      }
    });
  }

  @override
  Future<bool> saveRefreshToken(String token) async => await _sharedPreferences.addString('refresh_token', token);

  @override
  Future<String?> getToken() async => _sharedPreferences.readString('refresh_token');

  @override
  Stream<UserEntities> getUser() => _streamController.stream;

  @override
  Future<bool> removeToken() async => _sharedPreferences.remove('refresh_token');

  @override
  Future<void> saveAccessToken(String token) {
    return _secureStorage.store('access_token', token);
  }

  @override
  Future<String?> getAccessToken() async => _secureStorage.get('access_token');

  @override
  void updateUserData(UserModel user) => _streamController.add(user);

  @override
  Future<bool> isTokenAvailable() async {
    final token = await _sharedPreferences.readString('refresh_token');
    return token != null;
  }

  @override
  void _isTokenAvailable() async {
    final isToken = await isTokenAvailable();
    if (isToken) startWebSocket();
  }

  @override
  Future startWebSocket() async {
    final token = await getToken();
    _webSocketService = await WebsocketClient().getWebSocket(authToken: token ?? 'No token available');
    _webSocketService.userStream.listen((user) {
      Log.loggerInformation('User data from WebSocket: $user');
      _streamController.add(user);
    }, onError: (error) {
      _streamController.addError(error);
    });
  }

  @override
  void disposeWebSocket() {
    _webSocketService.disconnect();
  }
}
