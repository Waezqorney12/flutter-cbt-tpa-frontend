import 'package:test_potensial/core/message/server_exception.dart';
import 'package:test_potensial/core/infrastructure/network/dio_client.dart';
import 'package:test_potensial/core/model/user_model.dart';
import 'package:test_potensial/features/auth/domain/datasource/login_remote_datasource.dart';
import 'package:test_potensial/core/token/token_local_datasource.dart';

class LoginRemoteDatasourceImpl implements LoginRemoteDataSource {
  final DioClient _client;
  final TokenLocalDatasource _localToken;
  const LoginRemoteDatasourceImpl(
    this._client,
    this._localToken,
  );
  @override
  Future<String> loginWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      final request = await _client.post('/api/login', data: UserModel(email: email, password: password).toJson());

      final token = request.data['data'];
      _localToken.saveAccessToken(token);

      return token;
    } on ServerException catch (e) {
      throw ServerException(message: "Server Error:${e.message}");
    }
  }

  @override
  Future<void> loginWithGoogle() {
    throw UnimplementedError();
  }
}
