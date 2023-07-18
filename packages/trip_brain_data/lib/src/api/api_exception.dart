//TODO remove

enum APIExceptionStatus {
  badRequest,
  serverError,
  networkError,
  unknownError,
  badResponse
}

class APIException implements Exception {
  APIException({required this.status, this.errorCode});

  final APIExceptionStatus status;
  final String? errorCode;
}
