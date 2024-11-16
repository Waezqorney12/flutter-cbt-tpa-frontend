abstract interface class ForgotPasswordRemoteDataSource {
  Future<String> sendEmail({
    required String email,
  });

  Future<String> verifyCode({
    required String code,
  });
}
