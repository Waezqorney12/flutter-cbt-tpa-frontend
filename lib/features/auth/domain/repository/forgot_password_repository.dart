import '../../../../core/utils/typedef_utils.dart';

abstract interface class ForgotPasswordRepository {
  FutureEither<String> sendEmail({
    required String email,
  });

  FutureEither<String> verifyCode({
    required String code,
  });
}