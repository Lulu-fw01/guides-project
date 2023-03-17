import 'package:guide_app/common/models/response_exception_body.dart';

class AppException implements Exception {
  AppException([this.message]);

  final String? message;
}

class FetchDataException extends AppException {
  FetchDataException(String message) : super(message);
}

class ResponseException implements Exception {
  ResponseException(this.responseBody);
  final ResponseExceptionBody? responseBody;
}

class BadRequestException extends ResponseException {
  BadRequestException([ResponseExceptionBody? responseBody])
      : super(responseBody);
}

class UnauthorizedException extends ResponseException {
  UnauthorizedException([ResponseExceptionBody? responseBody])
      : super(responseBody);
}

class InvalidInputException extends ResponseException {
  InvalidInputException([ResponseExceptionBody? responseBody])
      : super(responseBody);
}

class ServerErrorException extends ResponseException {
  ServerErrorException([ResponseExceptionBody? responseBody])
      : super(responseBody);
}