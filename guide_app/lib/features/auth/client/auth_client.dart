import 'dart:convert';

import 'package:guide_app/common/api/api_constants.dart';
import 'package:guide_app/common/exceptions/fetch_data_exception.dart';
import 'package:guide_app/features/auth/client/dto/auth_dto.dart';
import 'package:guide_app/features/auth/client/i_auth_client.dart';
import 'package:http/http.dart' as http;

class AuthClient implements IAuthClient {
  @override
  Future<String> login(AuthDto dto) {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  Future<String> signUp(AuthDto dto) async {
    var url = Uri.parse(
      ApiConstants.baseUrl + ApiConstants.signUpEndpoint,
    );
    String response = '';
    try {
      var response = await http.post(url,
          headers: {"Content-Type": "application/json"}, body: dto);
      if (response.statusCode != 200) {
        // TODO throw error if wrong code.
      }
      var body = jsonDecode(response.body);
      response = body['token'];
    } catch (e) {
      throw FetchDataException('No Internet connection.');
    }
    return response;
  }
}
