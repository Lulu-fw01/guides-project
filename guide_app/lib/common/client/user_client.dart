import 'dart:convert';

import 'package:http/http.dart' as http;

import '../api/api_constants.dart';
import '../exceptions/app_exception.dart';
import 'i_user_client.dart';

/// UserClient.
/// TODO refactoring.
class UserClient implements IUserClient {
  UserClient({this.token});
  final String? token;
  @override
  Future<http.Response> getUserInfo(String email) {
    if (token == null) {
      throw UnauthorizedException();
    }
    return getUserInfoOutsideToken(email, token!);
  }

  /// Get info about user.
  /// [email] - user email.
  /// <p>
  /// [jwt] - JWT.
  /// <p>
  /// Throws [FetchDataException].
  /// <p>
  /// Author - @Lulu-fw01.
  @override
  Future<http.Response> getUserInfoOutsideToken(
      String email, String jwt) async {
    final url = Uri.parse("${ApiConstants.users}/$email");
    try {
      var response = http.get(url, headers: {
        "Authorization": 'Bearer $jwt',
        "Content-Type": "application/json"
      });
      return response;
    } catch (e) {
      throw FetchDataException(e.toString());
    }
  }
}
