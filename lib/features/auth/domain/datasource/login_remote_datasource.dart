import 'package:test_potensial/core/model/user_model.dart';

abstract interface class LoginRemoteDataSource {
  Future<UserModel> loginWithEmailPassword({
    required String email,
    required String password,
  });
}
