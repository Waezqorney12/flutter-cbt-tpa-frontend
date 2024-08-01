import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_potensial/core/failure/server_exception.dart';
import 'package:test_potensial/core/infrastructure/network/dio_client.dart';
import 'package:test_potensial/features/auth/data/model/user_model.dart';
import 'package:test_potensial/features/auth/domain/datasource/login_remote_datasource.dart';

import '../../../../core/utils/log.dart';

class LoginRemoteDatasourceImpl implements LoginRemoteDataSource {
  final DioClient _client;
  final SharedPreferences _sharedPreferences;
  const LoginRemoteDatasourceImpl(this._client, this._sharedPreferences);
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
      Log.loggerInformation("LoginRemoteDatasourceImpl: ${request.data['access_token']}");
      return UserModel.fromJson(request.data['message']);
    } on DioException catch (e) {
      Log.loggerError("Dio Error: ${e.message}");
      rethrow;
    } on ServerException catch (e) {
      Log.loggerError("Error: ${e.message}");
      throw ServerException(message: "Server Error:${e.message}");
    }
  }
}
