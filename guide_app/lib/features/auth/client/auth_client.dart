import 'package:flutter/widgets.dart';
import 'package:guide_app/common/api/api_constants.dart';
import 'package:guide_app/common/exceptions/app_exception.dart';
import 'package:guide_app/features/auth/client/dto/auth_dto.dart';
import 'package:guide_app/features/auth/client/i_auth_client.dart';
import 'package:http/http.dart' as http;

class AuthClient implements IAuthClient {
  @override
  Future<http.Response> login(AuthDto dto) {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  Future<http.Response> signUp(AuthDto dto) async {
    var url = Uri.parse(
      ApiConstants.baseUrl + ApiConstants.signUpEndpoint,
    );
    debugPrint('Calling endpoint $url');
    try {
      var response = await http.post(url,
          headers: {"Content-Type": "application/json"}, body: dto);
      debugPrint('Got response.');
      return response;
    } catch (e) {
      throw FetchDataException('No Internet connection.');
    }
  }
}
