import 'package:test_potensial/core/utils/typedef_utils.dart';

abstract interface class RegisterRepository {
  FutureEither<String> registerWithEmailPassword({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  });
}
