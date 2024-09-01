
import 'package:test_potensial/core/entities/user_entities.dart';
import 'package:test_potensial/core/utils/typedef_utils.dart';

abstract interface class LoginRepository {
  FutureEither<UserEntities> loginWithEmailPassword({
    required String email,
    required String password,
  });

}
