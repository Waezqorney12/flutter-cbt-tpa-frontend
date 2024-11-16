
abstract interface class RegisterRemoteDataSource {
  Future<String> registerWithEmailPassword({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  });

  Future<void> registerWithGoogle();
}
