import 'package:test_potensial/core/utils/typedef_utils.dart';

abstract interface class RegisterRepository {
  FutureEither<String> registerWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });
}
