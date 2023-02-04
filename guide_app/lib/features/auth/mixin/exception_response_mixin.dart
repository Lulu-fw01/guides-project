import 'dart:convert';

import 'package:guide_app/common/exceptions/app_exception.dart';
import 'package:guide_app/common/models/response_exception_body.dart';
import 'package:http/http.dart' as http;

mixin ExceptionResponseMixin {
  /// Method which throws exceptions with error response messages.
  /// Params: [http.Response] object.
  /// Throws [BadRequestException], [UnauthorizedException], [FetchDataException].
  /// @Lulu-fw01
  void throwError(http.Response response) {
    try {
      switch (response.statusCode) {
        case 400:
          final body =
              ResponseExceptionBody.fromJson(jsonDecode(response.body));
          throw BadRequestException(body);
        case 401:
        case 403:
          final body =
              ResponseExceptionBody.fromJson(jsonDecode(response.body));
          throw UnauthorizedException(body);
        case 500:
      }
    } catch (e) {
      // TODO maybe add something.
    }
    throw FetchDataException(
        'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
  }
}
