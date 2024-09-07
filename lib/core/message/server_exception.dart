class ServerException implements Exception {
  final String message;
  const ServerException({required this.message});

  @override
  String toString() => "ServerException: $message";
}
