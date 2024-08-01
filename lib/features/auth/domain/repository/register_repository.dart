import 'package:fpdart/fpdart.dart';
import 'package:test_potensial/core/failure/failure_message.dart';
import 'package:test_potensial/features/auth/domain/entities/user_entities.dart';

abstract interface class RegisterRepository {
  Future<Either<FailureMessage, UserEntities>> registerWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });
}
