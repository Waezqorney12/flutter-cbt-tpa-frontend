import 'package:fpdart/fpdart.dart';
import 'package:test_potensial/core/failure/failure_message.dart';
import 'package:test_potensial/core/utils/function_helper_utils.dart';
import 'package:test_potensial/features/auth/domain/datasource/register_remote_datasource.dart';
import 'package:test_potensial/features/auth/domain/entities/user_entities.dart';
import 'package:test_potensial/features/auth/domain/repository/register_repository.dart';

class RegisterRepositoryImpl implements RegisterRepository {
  final RegisterRemoteDataSource _remoteDataSource;
  const RegisterRepositoryImpl(this._remoteDataSource);
  @override
  Future<Either<FailureMessage, UserEntities>> registerWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) =>
      helperCall<UserEntities>(
        apiCall: () async => _remoteDataSource.registerWithEmailPassword(
          email: email,
          password: password,
          name: name,
        ),
      );
}
