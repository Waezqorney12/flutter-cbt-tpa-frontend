import 'package:test_potensial/features/auth/data/model/user_model.dart';

abstract interface class LoginRemoteDataSource {
  Future<UserModel> loginWithEmailPassword({
    required String email,
    required String password,
  });
}
