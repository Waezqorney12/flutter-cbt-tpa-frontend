import 'package:dio/dio.dart';
import 'package:test_potensial/core/message/server_exception.dart';
import 'package:test_potensial/core/infrastructure/network/dio_client.dart';
import 'package:test_potensial/core/token/token_local_datasource.dart';
import 'package:test_potensial/core/utils/log.dart';
import 'package:test_potensial/core/model/user_model.dart';
import 'package:test_potensial/features/auth/domain/datasource/register_remote_datasource.dart';

class RegisterRemoteDatasourceImpl implements RegisterRemoteDataSource {
  final DioClient _client;
  final TokenLocalDatasource _sharedPreferences;
  const RegisterRemoteDatasourceImpl(this._client, this._sharedPreferences);
  @override
  Future<UserModel> registerWithEmailPassword({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final request = await _client.post(
        '/api/register',
        data: UserModel(name: name, email: email, password: password, phone: '', roles: '').toJson(),
      );
      Log.loggerInformation("RegisterRemoteDatasourceImpl: ${request.data}");
      _sharedPreferences.saveAccessToken(request.data['access_token']);
      Log.loggerInformation("RegisterRemoteDatasourceImpl: ${await _sharedPreferences.getAccessToken()}");
      if (await _sharedPreferences.getAccessToken() != null) {
        Log.loggerInformation("RegisterRemoteDatasourceImpl: ${await _sharedPreferences.getAccessToken()}");
        _sharedPreferences.saveRefreshToken(await _sharedPreferences.getAccessToken() ?? '');
      }
      return UserModel.fromJson(request.data['user']);
    } on DioException catch (e) {
      Log.loggerError("Error: ${e.message}");
      throw Exception(e.message);
    } on ServerException catch (e) {
      Log.loggerError("Error: ${e.message}");
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<void> registerWithGoogle() {
    // TODO: implement registerWithGoogle
    throw UnimplementedError();
  }
}
