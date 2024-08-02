import 'package:fpdart/fpdart.dart';
import 'package:test_potensial/core/failure/failure_message.dart';
import 'package:test_potensial/core/entities/user_entities.dart';

abstract interface class LoginRepository {
  Future<Either<FailureMessage, UserEntities>> loginWithEmailPassword({
    required String email,
    required String password,
  });

}
