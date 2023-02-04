import 'package:guide_app/features/auth/client/dto/auth_dto.dart';
import 'package:http/http.dart' as http;

abstract class IAuthClient {
  Future<http.Response> signUp(AuthDto dto);
  Future<http.Response> login(AuthDto dto);
}
