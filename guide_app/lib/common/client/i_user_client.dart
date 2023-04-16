import 'package:http/http.dart' as http;

abstract class IUserClient {
  Future<http.Response> getUserInfo(String email);
  Future<http.Response> getUserInfoOutsideToken(String email, String token);
}
