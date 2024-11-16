
import 'package:test_potensial/core/utils/typedef_utils.dart';

abstract interface class LoginRepository {
  FutureEither<String> loginWithEmailPassword({
    required String email,
    required String password,
  });

}
