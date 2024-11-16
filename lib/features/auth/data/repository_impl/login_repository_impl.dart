import 'package:test_potensial/core/utils/function_helper_utils.dart';
import 'package:test_potensial/features/auth/domain/datasource/login_remote_datasource.dart';
import 'package:test_potensial/features/auth/domain/repository/login_repository.dart';

import '../../../../core/utils/typedef_utils.dart';

class LoginRepositoryImpl implements LoginRepository {
  final LoginRemoteDataSource _remoteDataSource;
  const LoginRepositoryImpl(this._remoteDataSource);
  @override
  FutureEither<String> loginWithEmailPassword({
    required String email,
    required String password,
  }) =>
      helperCall<String>(
        apiCall: () => _remoteDataSource.loginWithEmailPassword(
          email: email,
          password: password,
        ),
      );
}
