import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:test_potensial/core/message/failure_message.dart';
import 'package:test_potensial/core/usecases/usecase_interface.dart';
import 'package:test_potensial/features/auth/domain/repository/register_repository.dart';

class UserRegisterUseCase implements UseCase<String, UserRegisterParams> {
  final RegisterRepository repository;

  const UserRegisterUseCase(this.repository);

  @override
  Future<Either<FailureMessage, String>> call(UserRegisterParams params) async => await repository.registerWithEmailPassword(
        email: params.email,
        password: params.password,
        firstName: params.firstName,
        lastName: params.lastName,
      );
}

class UserRegisterParams extends Equatable {
  final String email;
  final String password;
  final String firstName;
  final String lastName;

  const UserRegisterParams({
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
  });

  @override
  List<Object> get props => [email, password, firstName, lastName];
}
