import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:test_potensial/core/failure/failure_message.dart';
import 'package:test_potensial/core/usecases/usecase_interface.dart';
import 'package:test_potensial/core/entities/user_entities.dart';
import 'package:test_potensial/features/auth/domain/repository/register_repository.dart';

class UserRegister implements UseCase<UserEntities, UserRegisterParams> {
  final RegisterRepository repository;

  const UserRegister(this.repository);

  @override
  Future<Either<FailureMessage, UserEntities>> call(UserRegisterParams params) async =>
      await repository.registerWithEmailPassword(
        email: params.email,
        password: params.password,
        name: params.name,
      );
}

class UserRegisterParams extends Equatable {
  final String email;
  final String password;
  final String name;

  const UserRegisterParams({
    required this.email,
    required this.password,
    required this.name,
  });

  @override
  List<Object> get props => [email, password, name];
}
