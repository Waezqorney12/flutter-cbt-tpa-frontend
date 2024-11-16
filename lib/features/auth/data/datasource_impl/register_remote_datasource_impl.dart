import 'package:dio/dio.dart';
import 'package:test_potensial/core/message/server_exception.dart';
import 'package:test_potensial/core/infrastructure/network/dio_client.dart';
import 'package:test_potensial/core/utils/log.dart';
import 'package:test_potensial/core/model/user_model.dart';
import 'package:test_potensial/features/auth/domain/datasource/register_remote_datasource.dart';

class RegisterRemoteDatasourceImpl implements RegisterRemoteDataSource {
  final DioClient _client;
  //final TokenLocalDatasource _sharedPreferences;
  const RegisterRemoteDatasourceImpl(
    this._client,
    //this._sharedPreferences,
  );
  @override
  Future<String> registerWithEmailPassword({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    try {
      final request = await _client.post(
        '/api/register',
        data: UserModel(
          firstName: firstName,
          lastName: lastName,
          email: email,
          password: password,
        ).toJson(),
      );
      return request.data['data'];
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
    throw UnimplementedError();
  }
}
