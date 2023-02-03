import 'dart:convert';

import 'package:guide_app/common/exceptions/app_exception.dart';
import 'package:guide_app/features/auth/client/dto/auth_dto.dart';
import 'package:guide_app/features/auth/client/i_auth_client.dart';
import 'package:guide_app/features/auth/repository/i_auth_repository.dart';
import 'package:http/http.dart' as http;

class AuthRepository implements IAuthRepository {
  AuthRepository(this.client);
  final IAuthClient client;

  @override
  Future<String> signIn(String email, String password) {
    return client.login(AuthDto(email, password)).then((response) {
      if (response.statusCode != 200) {
        _throwError(response);
      }
      var body = jsonDecode(response.body);
      return body['token'];
    });
  }

  @override
  Future<String> signUp(String email, String password) {
    return client.signUp(AuthDto(email, password)).then((response) {
      if (response.statusCode != 200) {
        _throwError(response);
      }
      var body = jsonDecode(response.body);
      return body['token'];
    });
  }

  // TODO move to mixin.
  void _throwError(http.Response response) {
    // TODO handle {"timestamp":"2023-02-03T23:24:37.352+00:00","status":400,"error":"Bad Request","message":"The user already exists","path":"/api/v1/auth/sign-up"}
    switch (response.statusCode) {
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorizedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
