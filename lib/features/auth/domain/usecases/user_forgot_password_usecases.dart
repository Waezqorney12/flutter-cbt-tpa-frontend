import 'package:test_potensial/core/utils/typedef_utils.dart';

import '../../../../core/usecases/usecase_interface.dart';
import '../repository/forgot_password_repository.dart';

class UserSendEmailUsecases implements UseCase<String, String> {
  final ForgotPasswordRepository repository;

  const UserSendEmailUsecases(this.repository);

  @override
  FutureEither<String> call(String params) {
    return repository.sendEmail(email: params);
  }
}

class UserVerifyOtpCodeUsecases implements UseCase<String, String> {
  final ForgotPasswordRepository repository;

  const UserVerifyOtpCodeUsecases(this.repository);

  @override
  FutureEither<String> call(String params) {
    return repository.verifyCode(code: params);
  }
}
