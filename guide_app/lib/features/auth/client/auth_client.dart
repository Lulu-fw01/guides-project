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

  // TODO move error handling to repo.
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
        _throwError(response);
      }
      var body = jsonDecode(response.body);
      response = body['token'];
    } catch (e) {
      throw FetchDataException('No Internet connection.');
    }
    return response;
  }

  // TODO implement function.
  void _throwError(http.Response response) {
    switch (response.statusCode) {
      case 400:
      //throw BadRequestException(response.body.toString());
      case 401:
      case 403:
      //throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
