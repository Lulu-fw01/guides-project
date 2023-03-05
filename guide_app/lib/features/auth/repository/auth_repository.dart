import 'dart:convert';

import 'package:guide_app/features/auth/client/dto/auth_dto.dart';
import 'package:guide_app/features/auth/client/dto/sign_up_dto.dart';
import 'package:guide_app/features/auth/client/i_auth_client.dart';
import 'package:guide_app/common/mixin/exception_response_mixin.dart';
import 'package:guide_app/features/auth/repository/i_auth_repository.dart';

/// Repository for authentication.
/// Author: @Lulu-fw01
class AuthRepository with ExceptionResponseMixin implements IAuthRepository {
  AuthRepository(this.client);
  final IAuthClient client;

  /// Login method.
  /// * Params: email(or login) and password.
  /// * Returns: JWT (json web token) String.
  /// * Throws: see [ExceptionResponseMixin.throwError].
  @override
  Future<String> signIn(String identifier, String password) {
    return client.login(AuthDto(identifier, password)).then((response) {
      if (response.statusCode != 200) {
        throwError(response);
      }
      var body = jsonDecode(response.body);
      return body['token'];
    });
  }

  /// Sign up method.
  /// * Params: login, email and password.
  /// * Returns: JWT (json web token) String.
  /// * Throws: see [ExceptionResponseMixin.throwError].
  @override
  Future<String> signUp(String login, String email, String password) {
    return client.signUp(SignUpDto(login, email, password)).then((response) {
      if (response.statusCode != 200) {
        throwError(response);
      }
      var body = jsonDecode(response.body);
      return body['token'];
    });
  }
}
