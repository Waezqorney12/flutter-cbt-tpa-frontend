import 'package:test_potensial/core/utils/function_helper_utils.dart';
import 'package:test_potensial/core/utils/typedef_utils.dart';
import 'package:test_potensial/features/auth/domain/repository/forgot_password_repository.dart';

import '../../domain/datasource/forgot_password_remote_datasource.dart';

final class ForgotPasswordRepositoryImpl implements ForgotPasswordRepository {
  final ForgotPasswordRemoteDataSource _remoteDataSource;
  const ForgotPasswordRepositoryImpl(this._remoteDataSource);

  @override
  FutureEither<String> sendEmail({required String email}) => helperCall(
        apiCall: () => _remoteDataSource.sendEmail(email: email),
      );

  @override
  FutureEither<String> verifyCode({required String code}) => helperCall(
        apiCall: () => _remoteDataSource.verifyCode(code: code),
      );
}
