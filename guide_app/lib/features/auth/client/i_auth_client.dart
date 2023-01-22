import 'package:guide_app/features/auth/client/dto/auth_dto.dart';

abstract class IAuthClient {
  Future<String> signUp(AuthDto dto);
  Future<String> login(AuthDto dto);
}
