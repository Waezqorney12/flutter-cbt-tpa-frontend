import 'package:dio/dio.dart';
import 'package:test_potensial/core/failure/exception.dart';
import 'package:test_potensial/core/failure/failure_message.dart';
import 'package:test_potensial/core/infrastructure/network/dio_client.dart';
import 'package:test_potensial/core/utils/log.dart';
import 'package:test_potensial/features/auth/data/model/user_model.dart';
import 'package:test_potensial/features/auth/domain/datasource/register_remote_datasource.dart';

class RegisterRemoteDatasourceImpl implements RegisterRemoteDataSource {
  final DioClient _client;
  const RegisterRemoteDatasourceImpl(this._client);
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
      return UserModel.fromJson(request.data['user']);
    } on DioException catch (e) {
      Log.loggerError("Error: ${e.message}");
      Log.loggerFatal("Response: ${e.response!.data['user']}");
      Log.loggerInformation("Uri: ${e.response!.requestOptions.uri}");
      throw FailureMessage(e.message!);
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }
}
