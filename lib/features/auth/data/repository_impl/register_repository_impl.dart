import 'package:test_potensial/core/utils/function_helper_utils.dart';
import 'package:test_potensial/core/utils/typedef_utils.dart';
import 'package:test_potensial/features/auth/domain/datasource/register_remote_datasource.dart';
import 'package:test_potensial/features/auth/domain/repository/register_repository.dart';

class RegisterRepositoryImpl implements RegisterRepository {
  final RegisterRemoteDataSource _remoteDataSource;
  const RegisterRepositoryImpl(this._remoteDataSource);
  @override
  FutureEither<String> registerWithEmailPassword({
    required String email,
    required String firstName,
    required String lastName,
    required String password,
  }) =>
      helperCall<String>(
        apiCall: () => _remoteDataSource.registerWithEmailPassword(
          email: email,
          firstName: firstName,
          lastName: lastName,
          password: password,
        ),
      );
}
