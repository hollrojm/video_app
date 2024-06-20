class ServerException implements Exception {
  final String message;

  ServerException(String s, {required this.message});
}

class NetworkException implements Exception {
  final String message;
  NetworkException(String s, {required this.message});
}

class ValidationException implements Exception {
  final String message;
  ValidationException(this.message);
}

class NotFoundException implements Exception {
  final String message;
  NotFoundException(this.message);
}
