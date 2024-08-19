import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:test_potensial/core/failure/failure_message.dart';
import 'package:test_potensial/core/usecases/usecase_interface.dart';
import 'package:test_potensial/core/entities/user_entities.dart';
import 'package:test_potensial/features/auth/domain/repository/login_repository.dart';

class UserLoginUseCase implements UseCase<UserEntities, UserLoginParams> {
  final LoginRepository repository;

  const UserLoginUseCase(this.repository);

  @override
  Future<Either<FailureMessage, UserEntities>> call(UserLoginParams params) async =>
      await repository.loginWithEmailPassword(email: params.email, password: params.password);
}

class UserLoginParams extends Equatable {
  final String email;
  final String password;

  const UserLoginParams({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [email, password];
}
