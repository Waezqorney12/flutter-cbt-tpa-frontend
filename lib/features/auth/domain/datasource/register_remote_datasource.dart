import 'package:test_potensial/features/auth/data/model/user_model.dart';


abstract interface class RegisterRemoteDataSource {
  Future<UserModel> registerWithEmailPassword({
    required String email,
    required String password,
    required String name,
  });
}
