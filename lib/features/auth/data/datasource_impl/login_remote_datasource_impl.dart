import 'package:test_potensial/core/message/server_exception.dart';
import 'package:test_potensial/core/infrastructure/network/dio_client.dart';
import 'package:test_potensial/core/model/user_model.dart';
import 'package:test_potensial/features/auth/domain/datasource/login_remote_datasource.dart';
import 'package:test_potensial/core/token/token_local_datasource.dart';

import '../../../../core/utils/log.dart';

class LoginRemoteDatasourceImpl implements LoginRemoteDataSource {
  final DioClient _client;
  final TokenLocalDatasource _sharedPreferences;
  const LoginRemoteDatasourceImpl(
    this._client,
    this._sharedPreferences,
  );
  @override
  Future<UserModel> loginWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      final request = await _client.post(
        '/api/login',
        data: UserModel(name: '', email: email, password: password, phone: '', roles: '').toJson(),
      );
      //Log.loggerInformation("LoginRemoteDatasourceImpl: ${request.data['access_token']}");
      _sharedPreferences.saveAccessToken(request.data['access_token']);
      //Log.loggerInformation("RegisterRemoteDatasourceImpl: ${await _sharedPreferences.getAccessToken()}");
      if (await _sharedPreferences.getAccessToken() != null) {
        Log.loggerInformation("RegisterRemoteDatasourceImpl: ${await _sharedPreferences.getAccessToken()}");
        _sharedPreferences.saveRefreshToken(await _sharedPreferences.getAccessToken() ?? '');
      }
      return UserModel.fromJson(request.data['message']);
    } on ServerException catch (e) {
      Log.loggerError("Error: ${e.message}");
      throw ServerException(message: "Server Error:${e.message}");
    }
  }

  @override
  Future<void> loginWithGoogle() {
    // TODO: implement loginWithGoogle
    throw UnimplementedError();
  }
}
