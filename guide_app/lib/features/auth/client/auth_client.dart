import 'dart:convert';

import 'package:guide_app/common/api/api_constants.dart';
import 'package:guide_app/common/exceptions/app_exception.dart';
import 'package:guide_app/features/auth/client/dto/auth_dto.dart';
import 'package:guide_app/features/auth/client/i_auth_client.dart';
import 'package:http/http.dart' as http;

/// Client for sign in and sign up.
class AuthClient implements IAuthClient {
  @override
  Future<http.Response> login(AuthDto dto) async {
    var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.loginEndpoint);
    try {
      var response = await http.post(url,
          headers: {"Content-Type": "application/json"}, body: jsonEncode(dto));
      return response;
    } catch (e) {
      throw FetchDataException(e.toString());
    }
  }

  /// Sign up in service.
  /// dto - dto with email and password and other credentials.
  /// Returns [http.Response].
  /// Throws [FetchDataException].
  /// Author - @Lulu-fw01.
  @override
  Future<http.Response> signUp(AuthDto dto) async {
    var url = Uri.parse(
      ApiConstants.baseUrl + ApiConstants.signUpEndpoint,
    );
    try {
      var response = await http.post(url,
          headers: {"Content-Type": "application/json"},
          body: json.encode(dto));
      return response;
    } catch (e) {
      throw FetchDataException(e.toString());
    }
  }
}
