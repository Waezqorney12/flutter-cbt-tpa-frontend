
abstract interface class LoginRemoteDataSource {
  Future<String> loginWithEmailPassword({
    required String email,
    required String password,
  });

  Future<void> loginWithGoogle();
}
