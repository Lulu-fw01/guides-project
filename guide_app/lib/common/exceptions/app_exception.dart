class AppException implements Exception {
  AppException([this.message]);

  final String? message;
}

class FetchDataException extends AppException {
  FetchDataException([String? message]) : super(message);
}

class BadRequestException extends AppException {
  BadRequestException([message]) : super(message);
}

class UnauthorizedException extends AppException {
  UnauthorizedException([message]) : super(message);
}

class InvalidInputException extends AppException {
  InvalidInputException([message]) : super(message);
}
