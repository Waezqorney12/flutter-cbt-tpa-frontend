import 'package:test_potensial/features/auth/data/model/user_model.dart';
import 'package:test_potensial/features/auth/domain/datasource/login_remote_datasource.dart';

class LoginRemoteDatasourceImpl implements LoginRemoteDataSource {
  @override
  Future<UserModel> loginWithEmailPassword({
    required String email,
    required String password,
  }) {
    // TODO: implement login
    throw UnimplementedError();
  }
}
