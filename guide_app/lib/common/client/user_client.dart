import 'dart:convert';

import 'package:http/http.dart' as http;

import '../api/api_constants.dart';
import '../exceptions/app_exception.dart';
import 'i_user_client.dart';

/// UserClient.
class UserClient implements IUserClient {
  @override
  Future<http.Response> getUserInfo(String email) {
    // TODO: implement getUserInfo
    throw UnimplementedError();
  }

  /// Get info about user.
  /// [email] - user email.
  /// <p>
  /// [token] - JWT.
  /// <p>
  /// Throws [FetchDataException].
  /// <p>
  /// Author - @Lulu-fw01.
  @override
  Future<http.Response> getUserInfoOutsideToken(
      String email, String token) async {
    final url = Uri.parse("${ApiConstants.users}/$email");
    try {
      var response = http.get(url, headers: {
        "Authorization": 'Bearer $token',
        "Content-Type": "application/json"
      });
      return response;
    } catch (e) {
      throw FetchDataException(e.toString());
    }
  }
}
