import 'package:test_potensial/core/model/user_model.dart';


abstract interface class RegisterRemoteDataSource {
  Future<UserModel> registerWithEmailPassword({
    required String email,
    required String password,
    required String name,
  });

  Future<void> registerWithGoogle();
}
